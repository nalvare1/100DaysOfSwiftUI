//
//  ExpenseItemView.swift
//  iExpenses
//
//  Created by Natalie Alvarez on 3/19/24.
//

import SwiftUI

struct ExpenseItemView: View {
    var expenseItem: ExpenseItem
    var currencyCode = "USD"
    var showPersonalExpenses = true

    func isPersonalExpense(expenseItem: ExpenseItem) -> Bool {
        return expenseItem.type == "Personal"
    }

    func isBusinessExpense(expenseItem: ExpenseItem) -> Bool {
        return expenseItem.type == "Business"
    }

    var shouldShow: Bool {
        if showPersonalExpenses {
            return isPersonalExpense(expenseItem: expenseItem)
        } else {
            return isBusinessExpense(expenseItem: expenseItem)
        }
    }

    var fontColor: Color? {
        var price = expenseItem.amount

        if (price < 2) {
            return .green
        } else if (price < 10) {
            return .blue
        } else if (price < 25) {
            return .purple
        } else {
            return .red
        }
    }

    var body: some View {
        if shouldShow {
            HStack {
                VStack(alignment: .leading) {
                    Text(expenseItem.name)
                        .font(.headline)
                        .foregroundColor(fontColor)

                    Text(expenseItem.type)
                        .foregroundColor(fontColor)
                }

                Spacer()

                Text(expenseItem.amount, format: .currency(code: currencyCode))
                    .foregroundColor(fontColor)
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses(), currencyCode: "USD")
}

