//
//  MainView.swift
//  iDine
//
//  Created by student on 2/4/25.
//

import SwiftUI

struct MainView: View {
    @Environment(Order.self) var order: Order
    @Environment(Favorites.self) var favorites: Favorites
    @State private var tabController = TabController()
//    @State private var favorites = Favorites()
    
    var body: some View {
        TabView(selection: $tabController.activeTab) {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .tag(DineTab.menuTab)
            
            FavoritesView() //the star displaying the favorites tab is between menu and order icons below
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(DineTab.favoritesTab)
                .badge(favorites.items.count)
                .environment(tabController)
            
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
                .badge(order.items.count)
                .tag(DineTab.orderTab)
                .environment(tabController)
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//            .environment(Order())
//    }
//}

enum DineTab {
    case menuTab
    case orderTab
    case favoritesTab
}

@Observable
class TabController {
    var activeTab = DineTab.menuTab
    
    func open(tab: DineTab) {
        activeTab = tab
    }
}

#Preview {
    MainView()
        .environment(Order())
        .environment(Favorites())
}

