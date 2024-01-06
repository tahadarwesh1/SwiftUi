//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Taha Darwish on 05/01/2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order : Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.userAddress.name)
                TextField("Street Address", text: $order.userAddress.streetAddress)
                TextField("City", text: $order.userAddress.city)
                TextField("Zip", text: $order.userAddress.zip)
            }
            Section {
                NavigationLink("Checkout") {
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
