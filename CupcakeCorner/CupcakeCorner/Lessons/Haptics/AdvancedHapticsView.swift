//
//  AdvancedHapticsView.swift
//  CupcakeCorner
//
//  Created by Natalie Alvarez on 4/9/24.
//

import CoreHaptics
import SwiftUI

/*
 CoreHaptics allows us to create hugely customizable haptics from scratch.
*/

struct AdvancedHapticsView: View {
    @State private var engine: CHHapticEngine?

    var body: some View {
        Button("Play Haptic", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        var events = [CHHapticEvent]()

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AdvancedHapticsView()
}
