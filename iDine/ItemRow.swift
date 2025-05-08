//
//  ItemRow.swift
//  iDine
//
//  Created by student on 2/4/25.
//

import SwiftUI

struct ItemRow: View {
    let item: MenuItem
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    
    var body: some View {
        HStack {
            Image(item.thumbnailImage)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
//                    .overlay(Circle().stroke(.gray, lineWidth: 2))
                Text("$\(item.price)")
            }
            Spacer()
            
            ForEach(item.restrictions, id: \.self) { restriction in
                Text(restriction)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(5)
                    .background(colors[restriction, default: .black])
                    .clipShape(Circle())
                    .foregroundStyle(.white)
            }
        }
    }
}

//struct ItemRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemRow(item: MenuItem.example)
//    }
//}

#Preview {
    ItemRow(item: MenuItem.example)
}
