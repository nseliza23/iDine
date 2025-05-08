//
//  OrderView.swift
//  iDine
//
//  Created by student on 2/4/25.
//

import SwiftUI

struct OrderView: View {
    @Environment(Order.self) var order: Order
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                Section {
                    NavigationLink("Place Order") {
                        CheckoutView()
                    }
                }
                .disabled(order.items.isEmpty)
            }
            .navigationTitle("Order")
            .toolbar {
                EditButton()
            }
        }
    }
    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
}

//struct OrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderView(order: <#Environment<Order>#>)
//            .environment(Order())
//    }
//}

#Preview {
    OrderView()
        .environment(Order())
}
