//
//  FavoritesView.swift
//  iDine
//
//  Created by student on 2/18/25.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(Favorites.self) var favorites
//    @Environment(Order.self) var order
    
    var body: some View {
        NavigationStack {
            List {
                if favorites.items.isEmpty {
                    VStack {
                        Text("No favorites at this time")
                            .font(.title2)
                            .italic()
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    ForEach(favorites.items) { item in
                        NavigationLink(destination: ItemDetail(item: item)) {
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("$\(item.price)")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
// tried to add button to add all the items in favorites list to the order automatically
//                Section {
//                    if !favorites.items.isEmpty {
//                        Button(action: addFavsToOrder) {
//                            Text("Add favorites to order") {
//                                .bold()
//                        }
//                    }
//                }
// tried to add a section to go back to the menu. this worked, but when i clicked on items in the menu again, it glitched, and would not let me add more items
//                Section {
//                    NavigationLink("Go to Menu") {
//                        MainView()
//                    }
//                }
                
                Section {
                    NavigationLink("Go to Order") {
                        OrderView()
                    }
                }
                .disabled(favorites.items.isEmpty)
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
        }
    }
            
        func deleteItems(at offsets: IndexSet) { //swipe to the left to delete
            favorites.items.remove(atOffsets: offsets)
        }
//function to add fav items to the order
//        func addFavsToOrder() {
//            for item in favorites.items {
//                order.add(item: item)
//            }
//    }
}

//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Label("Favorites", systemImage: "star")
//                .font(.system(size: 40, weight: .bold))
//                .bold()
//                .font(.largeTitle)
//                .padding([.top, .leading])
//            
//            List {
//                Text("Fav 1")
//                Text("fav 2")// whenever a favorite item is added, it appears here
//            }
//            .navigationTitle("Favorites")
//            .listStyle(.grouped)
//        }
//    }
//}

#Preview {
    FavoritesView()
        .environment(Favorites())
}

