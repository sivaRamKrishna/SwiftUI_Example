//
//  ItemDetailView.swift
//  iDine
//
//  Created by Siva on 09/09/20.
//  Copyright © 2020 Siva. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {
    @EnvironmentObject var order: Order
    var item: MenuItem
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                .offset(x: -25, y: -5)
            }
            Text(item.description)
            .padding()
            Button("Order this") {
                self.order.add(item: self.item)
            }.font(.headline)
            Spacer()
        }.navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        NavigationView {
            ItemDetailView(item: MenuItem.example).environmentObject(order)
        }
    }
}
