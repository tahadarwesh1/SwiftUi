//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Taha Darwish on 05/01/2024.
//

import SwiftUI

struct CheckoutView: View {
    var order : Order
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg") , scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300 )
                Text("Your total cost is \(order.cost , format: .currency(code: "USD"))" )
                    .font(.title)
                    .bold()
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(alertTitle, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("An Error occured while encoding data")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertTitle = "Thank you!"
            alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            print(decodedOrder)
            print(decodedOrder.name)
            print(decodedOrder.quantity)
            print(decodedOrder.streetAddress)
        } catch {
            alertTitle = "Error"
            alertMessage = "Checkout failed: \(error.localizedDescription)"
            showingConfirmation = true
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
