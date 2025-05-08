//
//  iDineApp.swift
//  iDine
//
//  Created by student on 2/3/25.
//

import SwiftUI

@main
struct iDineApp: App { 
//    @State var order = Order() //changed StateObject to State
//    @State var favorites = Favorites()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(Order())
                .environment(Favorites())
        }
    }
}
