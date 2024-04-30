//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Natalie Alvarez on 4/15/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize) // Lets us disable the scrolling bounce behavior when the content fits in the view (i.e. a good way to disable scrolling based on dynamicTypeSize!!)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") {
                showingAlert = false
            }
        } message: {
            Text("\(alertMessage)")
        }
        //.alert("Order failed", isPresented: $showingFailure)
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)

            // handle our request
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            orderSuccessAlert(quantity: decodedOrder.quantity, flavor: decodedOrder.flavor)
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            orderFailureAlert(errorDescription: error.localizedDescription)
        }
    }

    func orderSuccessAlert(quantity: Int, flavor: Int) {
        alertTitle = "Thank you!"
        alertMessage = "Your order for \(quantity) \(Order.flavors[flavor]) cupcake(s) is on its way!"
        showingAlert = true
    }

    func orderFailureAlert(errorDescription: String) {
        alertTitle = "Order failed!"
        alertMessage = "Your order checkout failed with error: \(errorDescription)"
        showingAlert = true
    }
}

#Preview {
    CheckoutView(order: Order())
}
