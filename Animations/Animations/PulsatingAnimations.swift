//
//  Animation1.swift
//  Animations
//
//  Created by Natalie Alvarez on 2/27/24.
//

import SwiftUI

// Creates a pulsating circle animation
struct Animation1: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
            // animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    // this creates a struct, so we can apply modifiers to it (ex: repeatForever() )
                    .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear() {
            animationAmount = 2
        }
        // .animation(.default, value: animationAmount) // apply a default animation whenever the value of animationAmount changes
    }
}

#Preview {
    Animation1()
}
