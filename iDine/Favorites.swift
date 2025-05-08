//
//  Favorites.swift
//  iDine
//
//  Created by student on 2/18/25.
//

import SwiftUI

@Observable
class Favorites {
    var items = [MenuItem]()
    
    func add(item: MenuItem) {
        if !items.contains(item) {
            items.append(item)
        }
    }
    
    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func contains(_ item: MenuItem) -> Bool {
        items.contains(item)
    }
}
