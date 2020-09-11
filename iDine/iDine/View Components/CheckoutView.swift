//
//  CheckoutView.swift
//  iDine
//
//  Created by Siva on 09/09/20.
//  Copyright © 2020 Siva. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    @State private var paymentType = 0
    @State private var addLoyalityDetails = false
    @State private var loyalityNumber = ""
    static let tipAmmounts = [10, 15, 20, 25]
    @State var tipAmmount = 1
    @State private var showingPaymentAlert: Bool = false
    static let pickUps = ["Today", "Today Night", "Morning"]
    @State var pickTime = 0
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmmounts[tipAmmount])
        return total + tipValue
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                Toggle(isOn: $addLoyalityDetails.animation()) {
                    Text("Add iDine loyality card")
                }
                if addLoyalityDetails {
                    TextField("Enter your iDine Card ID", text: $loyalityNumber)
                }
            }
            
            Section (header: Text("Add a tip?")) {
                Picker("Percentage", selection: $tipAmmount) {
                    ForEach(0 ..< Self.tipAmmounts.count) {
                        Text("\(Self.tipAmmounts[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section (header: Text("Pickup Time")) {
                Picker("Percentage", selection: $pickTime) {
                    ForEach(0 ..< Self.pickUps.count) {
                        Text("\(Self.pickUps[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Total $\(totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                Button ("Confirm Order") {
                    self.showingPaymentAlert.toggle()
                }
            }
        }.alert(isPresented: $showingPaymentAlert) { () -> Alert in
            Alert(title: Text("Order Confirmed"), message: Text("Your total was $\(totalPrice, specifier: "%.2f") – thank you!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
