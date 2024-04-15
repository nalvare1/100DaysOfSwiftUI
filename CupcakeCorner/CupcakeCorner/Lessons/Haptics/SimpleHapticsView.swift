//
//  SimpleHapticsView.swift
//  CupcakeCorner
//
//  Created by Natalie Alvarez on 4/9/24.
//

import SwiftUI

struct SimpleHapticsView: View {
    @State private var counter = 0

    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
    }
}

#Preview {
    SimpleHapticsView()
}
