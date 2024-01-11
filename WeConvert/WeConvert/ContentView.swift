//
//  ContentView.swift
//  WeConvert
//
//  Created by Natalie Alvarez on 11/6/23.
//

import SwiftUI

struct Title: ViewModifier { // Day 24
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool

    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    var remainingUnits: [String] {
        units.filter { unit in
            unit != beforeUnit
        }
    }

    @State private var beforeUnit: String = "Celsius"
    @State private var beforeValue: Double = 0.0
    @State private var afterUnit: String = "Fahrenheit"

    func convertFahrenheitToCelsius(for fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5 / 9
    }

    func convertCelsiusToFahrenheit(for celsius: Double) -> Double {
        return (celsius * 9 / 5) + 32
    }

    func convertCelsiusToKelvin(for celsius: Double) -> Double {
        return celsius + 273.15
    }

    func convertKelvinToCelsius(for kelvin: Double) -> Double {
        return kelvin - 273.15
    }

    func convertFahrenheitToKelvin(for fahrenheit: Double) -> Double {
        let celsius = convertFahrenheitToCelsius(for: fahrenheit)
        return convertCelsiusToKelvin(for: celsius)
    }

    func convertKelvinToFahrenheit(for kelvin: Double) -> Double {
        let celsius = convertKelvinToCelsius(for: kelvin)
        return convertCelsiusToFahrenheit(for: celsius)
    }

    var afterValue: Double {
        print("beforeUnit: \(beforeUnit)")
        print("afterUnit: \(afterUnit)")
        switch(beforeUnit) {
            case "Celsius":
                switch(afterUnit) {
                case "Fahrenheit":
                    return convertCelsiusToFahrenheit(for: beforeValue)
                case "Kelvin":
                    return convertCelsiusToKelvin(for: beforeValue)
                default:
                    return beforeValue
                }
            case "Fahrenheit":
                switch(afterUnit) {
                case "Celsius":
                    return convertFahrenheitToCelsius(for: beforeValue)
                case "Kelvin":
                    return convertFahrenheitToKelvin(for: beforeValue)
                default:
                    return beforeValue
                }
            case "Kelvin":
                switch(afterUnit) {
                case "Celsius":
                    return convertKelvinToCelsius(for: beforeValue)
                case "Fahrenheit":
                    return convertKelvinToFahrenheit(for: beforeValue)
                default:
                    return beforeValue
                }
        default:
            return 0
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Text("WeConvert")
                    //.modifier(Title())
                    .titleStyle() // Day 24

                Section("Temperature") {
                    Picker("Unit", selection: $beforeUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }

                    TextField("", value: $beforeValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                // update afterUnit:
                .onChange(of: beforeUnit) { newBeforeUnit in
                    if newBeforeUnit == afterUnit {
                        afterUnit = remainingUnits.first ?? ""
                    }
                }

                Section("Convert To") {
                    Picker("Unit", selection: $afterUnit) {
                        ForEach(remainingUnits, id: \.self) {
                            Text($0)
                        }
                    }

                    Text(afterValue, format: .number)
                }
            }
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

extension View { // Day 24
    func titleStyle() -> some View {
        modifier(Title())
    }
}

#Preview {
    ContentView()
}
