//
//  CheckoutView.swift
//  iDine
//
//  Created by student on 2/4/25.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(Order.self) var order: Order
    
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    
    let tipAmounts = [10, 15, 20, 25, 0]
    @State private var tipAmount = 15
    
    @State private var showingPaymentAlert = false
    @Environment(\.dismiss) private var dismiss
    @Environment(TabController.self) private var tabController
    
    let pickupTimes = ["Now", "Tonight", "Tomorrow Morning"]
    @State private var pickupTime = "Now"
    
    var totalPrice: String {
        let total = Double(order.total)
        let tipValue = total/100 * Double(tipAmount)
        return (total + tipValue).formatted(.currency(code: "USD"))
    }
    
    var body: some View {
        Form {
            Section {
                // two way binder is why you need $
                Picker("Choose your payment method:", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
                
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            
            Section("Add a tip?") {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            // section to choose pick up time
            // .segmented is a cleaner way to present the options, but the option "tomorrow morning" would not fit accordingly.
            Section("Pickup time: ") {
                Picker("Select a Time:", selection: $pickupTime) {
                    ForEach(pickupTimes, id: \.self) { time in
                        Text(time)
                    }
                }
                .pickerStyle(.inline)
            }
            
            Section("Total: \(totalPrice)") {
                Button("Confirm Order") {
                    //place order
                    showingPaymentAlert.toggle()
                    
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order confirmed!", isPresented: $showingPaymentAlert) {
            //buttons to be added
            Button("OK") {
                print("pressed ok button")
                order.items.removeAll()
                dismiss()
            }
            
        } message: {
            Text("Your total was \(totalPrice) - thank you!!")
        }
        .onChange(of: order.items.count) {
            if order.items.count == 0 {
                tabController.open(tab: .menuTab)
            }
        }
    }
}

//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView(order: <#Environment<Order>#>)
//            .environment(Order())
//            .environment(TabController())
//    }
//}

#Preview {
    CheckoutView()
        .environment(Order())
        .environment(TabController())
}
