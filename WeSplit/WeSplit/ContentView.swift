//
//  ContentView.swift
//  WeSplit
//
//  Created by Natalie Alvarez on 10/31/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeopleIndex = 2 // not sure why this is an index
    @State private var tipSelected = 20      // and this is not
    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [0, 5, 10, 15, 20, 25]

    var numberOfPeople: Double {
        Double(numberOfPeopleIndex + 2)
    }

    var tipPercentage: Double {
        (Double(tipSelected) / 100)
    }

    var checkTotal: Double {
        checkAmount * (1 + tipPercentage)
    }

    var totalPerPerson: Double {
        checkTotal / numberOfPeople
    }

    var tipIsZero: Bool {
        tipSelected == 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Check Amount") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeopleIndex) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $tipSelected) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Total Check Amount") {
                    Text(checkTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipIsZero ? .red : .primary) // Day 24
                }

                Section("Total Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
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

#Preview {
    ContentView()
}


// Day 16 - Notes:
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section {
//                    Text("Hello, world!")
//                    Text("Hello, world!")
//                    Text("Hello, world!")
//                }
//                Section {
//                    Text("Hello, world!")
//                    Text("Hello, world!")
//                }
//            }
//            .navigationTitle("SwiftUI")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}

//struct ContentView: View {
//    @State var tapCount = 0 // allows us to modify our view struct freely
//
//    var body: some View {
//        Button("Tap Count: \(tapCount)") {
//            tapCount += 1
//        }
//    }
//}

//struct ContentView: View {
//    @State private var name = ""
//
//    var body: some View {
//        Form {
//            TextField("Enter your name", text: $name) // a two-way Binding = read and write the value automatically
//            Text("Your name is \(name)") // This is just reading the value, so we don't need to make it Binding
//        }
//    }
//}

//struct ContentView: View {
//    let students = ["Harry", "Hermione", "Ron"]
//    @State private var selectedStudent = "Harry"
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Picker("Select your student", selection: $selectedStudent) {
//                    ForEach(students, id: \.self) {
//                        Text($0)
//                    }
//                }
//            }
//        }
//    }
//}
