//
//  Animation2.swift
//  Animations
//
//  Created by Natalie Alvarez on 2/28/24.
//

import SwiftUI

// Scales up/down a red circle
struct Animation2: View {
    @State private var animationAmount = 1.0

    var body: some View {
        print(animationAmount)

        return VStack {
            // Binding animation:
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
        }
    }
}

#Preview {
    Animation2()
}
