//
//  ContentView.swift
//  iExpenses
//
//  Created by Natalie Alvarez on 3/18/24.
//

import SwiftUI

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        // Save items to UserDefaults when they are edited:
        didSet {
            if let encoded = try? JSONEncoder().encode(items) { // NOTE: you can only use "encode" on objects that conform to the Codable protocol
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    // Reload saved items:
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            // "[ExpenseItem].self" refers to the type of an array of ExpenseItems, and tells Swift not to create one
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var currencyCode = "USD"

//    var personalExpenses: [ExpenseItem] {
//        return expenses.items.filter { $0.type == "Personal" }
//    }

    // https://medium.com/@sparsh_gupta75/currency-code-picker-in-swiftui-4c91bfcb950
    let availableCurrencyCodes: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }
    }()

    func currencyName(currencyCode: String) -> String {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]))
        return locale.localizedString(forCurrencyCode: currencyCode) ?? currencyCode
    }

    var body: some View {
        NavigationStack {
            Picker("Select Currency", selection: $currencyCode) {
                ForEach(availableCurrencyCodes, id:\.self) { code in
                    Text("\(currencyName(currencyCode: code)) (\(code))")
                        .tag(code)
                }
            }
            .pickerStyle(WheelPickerStyle())

            Text("Selected Currency: \(currencyName(currencyCode: currencyCode)) (\(currencyCode))")
                .padding()

            List {
                Text("Expenses")
                    .font(.title3).fontWeight(.semibold)

                Text("Personal")
                    .font(.headline)

                ForEach(expenses.items) { item in
                    ExpenseItemView(expenseItem: item, currencyCode: currencyCode, showPersonalExpenses: true)
                }
                .onDelete(perform: removeItems)

                Text("Business")
                    .font(.headline)

                ForEach(expenses.items) { item in
                    ExpenseItemView(expenseItem: item, currencyCode: currencyCode, showPersonalExpenses: false)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    // let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    // expenses.items.append(expense)
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses, currencyCode: currencyCode)
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
