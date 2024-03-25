//
//  Animation4.swift
//  Animations
//
//  Created by Natalie Alvarez on 3/1/24.
//

import SwiftUI

// Animate a Red box that when tapped, turns/bounces into a blue rounded rectangle
struct Animation4: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
        }
        // In SwiftUI, the order of the modifiers matters, especially for animations:
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .foregroundStyle(.white)
        .animation(.default, value: enabled) // This animation controls the button and rectangle itself^^
        
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled) // This animation controls the rounding of the rectangle's edges^^
    }
}

#Preview {
    Animation4()
}

