//
//  ContentView.swift
//  Animations
//
//  Created by Natalie Alvarez on 2/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount) // apply a default animation (.default = .spring) whenever the value of animationAmount changes
    }
}

#Preview {
    ContentView()
}
