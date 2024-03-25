//
//  ContentView.swift
//  BetterRest
//
//  Created by Natalie Alvarez on 1/11/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

    var recommendedBedTime: String {
        return getBedtime()
    }

    var body: some View {
        NavigationStack {
             Form {
                 Section(header: Text("When do you want to wake up?")) {
                     DatePicker("Please enter a time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                         .labelsHidden()
                 }

                 Section(header: Text("Desired amount of sleep")) {
                     Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                 }

                 Section(header: Text("Daily coffee intake")) {
                     // SwiftUI has this method to say "1 cup", "2 cups", etc.
                     //Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...20)

                     Picker("Daily coffee intake", selection: $coffeeAmount) {
                         ForEach(0..<21) {
                             Text("^[\($0) cup](inflect: true)")
                         }
                     }
                     .labelsHidden()
                 }

                 Section(header: Text("Your ideal bedtime is...")) {
                     Text("\(recommendedBedTime)")
                 }
            }
            .navigationTitle("Better Rest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                // "OK" button with no action:
//                Button("OK") { }
//            } message : {
//                Text(alertMessage)
//            }
        }
    }

    // Original solution (Day 27):
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let bedTime = wakeUpTime - prediction.actualSleep

            alertTitle = "Your ideal bedtime is..."
            alertMessage = bedTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }

        showingAlert = true
    }

    // Challenge solution (Day 28):
    func getBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let bedTime = wakeUpTime - prediction.actualSleep

            return bedTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return ""
        }
    }
}

#Preview {
    ContentView()
}
