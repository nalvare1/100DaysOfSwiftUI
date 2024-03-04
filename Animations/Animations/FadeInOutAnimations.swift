//
//  FadeInOutAnimations.swift
//  Animations
//
//  Created by Natalie Alvarez on 3/1/24.
//

import SwiftUI

// A gradient (yellow/red) rectangle that can be dragged across the screen.
struct Animation7: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity)) // scales up, and fades out
            }
        }
    }
}

#Preview {
    Animation7()
}
