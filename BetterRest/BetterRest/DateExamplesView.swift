//
//  DateExamplesView.swift
//  BetterRest
//
//  Created by Natalie Alvarez on 1/11/24.
//

import SwiftUI

struct DateExamplesView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now

    var body: some View {
        VStack {
            Spacer()

            Text(Date.now, format: .dateTime.hour().minute())

            Text(Date.now, format: .dateTime.day().month().year())

            Text(Date.now.formatted(date: .long, time: .shortened))

            Spacer()

            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
                .labelsHidden()

            DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden() // use this, instead of making the label an empty string (to prevent weird formatting, and also for accessibility text)

            Spacer()

            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25) // starts at 8 hours, and can range from 4 to 12 hours. The "step" parameter makes each +/- change by 25% of an hour (15min)

            Spacer()
        }
    }

    func exampleDates() {
        // This code will have issues bc not every day has 86400s:
        /* let now = Date.now
           let tomorrow = Date.now.addingTimeInterval(86400) // aka "this time tomorrow"
           let range = now...tomorrow */

        // Option 1:
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now

        // Option 2:
        let components2 = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour2 = components2.hour ?? 0
        let minute2 = components2.minute ?? 0
    }
}

#Preview {
    DateExamplesView()
}
