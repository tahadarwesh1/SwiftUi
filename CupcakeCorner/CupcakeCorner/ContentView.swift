//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Taha Darwish on 02/01/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var order = Order()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select you cake type", selection: $order.type) {
                        ForEach(Order.types.indices , id:\.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes : \(order.quantity)", value: $order.quantity , in: 3...20)
                }
                Section {
                    Toggle("Any sepecial request", isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivary Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
