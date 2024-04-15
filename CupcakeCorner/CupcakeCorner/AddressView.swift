//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Natalie Alvarez on 4/15/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zipCode)
            }

            Section {
                NavigationLink("Check Out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
