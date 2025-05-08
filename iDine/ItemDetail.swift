//
//  ItemDetail.swift
//  iDine
//
//  Created by student on 2/4/25.
//

import SwiftUI

struct ItemDetail: View {
    let item: MenuItem
    
    @Environment(Order.self) var order: Order
    @Environment(\.dismiss) private var dismiss
    @Environment(Favorites.self) var favorites: Favorites
    
    @State private var favorited: Bool = false // this is to keep track of if an item has been favorited or not
    
    var body: some View {
        VStack {
            Image(systemName: favorited ? "star.fill": "star")
                .resizable()
                .foregroundStyle(.orange)
                .bold()
                .frame(width: 30, height: 30)
                .onTapGesture {
                    if favorites.contains(item) {
                        favorites.remove(item: item)
                        favorited = false //when item is removed from favorites it is false
                    }
                    else {
                        favorites.add(item: item)
                        favorited = true //when item is added to favorites it is true so that the star remains filled, hence showing that the item has already been favorited
                    }
                }
            
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            
            Text(item.description)
                .padding()
            
            Button("Order This") {
                order.add(item: item)
                dismiss() //dismisses back to menu
            }
            .buttonStyle(CustomOrderButtonStyle())
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            favorited = favorites.contains(item)
        }
    }
}

//struct ItemDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            ItemDetail(item: MenuItem.example)
//                .environment(Order())
//        }
//    }
//}

struct CustomOrderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title.bold())
            .font(.custom("Avenir Next Condensed", size: 24)).fontWeight(.heavy).italic()
            .foregroundStyle(.white)
            .padding(.horizontal, 25)
            .padding(.vertical, 8)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 1.0, green: 0.6, blue: 0.2), Color(.sRGB, red: 0.9, green: 0.3, blue: 0.1)]), startPoint: .top, endPoint: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .scaleEffect(x: 0.96, y: 0.8)
//                        .blendMode(.multiply)
                    
                    if configuration.isPressed {
                        LinearGradient(
                            gradient: Gradient(colors: [Color(.sRGB, red: 0.8, green: 0.4, blue: 0.1), Color(.sRGB, red: 0.7, green: 0.2, blue: 0.1)]),
                            startPoint: .top, endPoint: .bottom)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .brightness(0.2) //darken when pressed
                    }
                }
            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 5)
//                    .stroke(Color(.sRGB, red: 1.0, green: 0.1, blue: 0.1), lineWidth: 2.5)
//            )
            .foregroundStyle(.red)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 2)
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(.orange)
//                    .brightness(configuration.isPressed ? 0.2 : 0.0) //ternary if- else
    }
}

#Preview {
    NavigationStack {
        ItemDetail(item: MenuItem.example)
            .environment(Order())
            .environment(Favorites())
    }
}
