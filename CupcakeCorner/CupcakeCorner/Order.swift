//
//  Order.swift
//  CupcakeCorner
//
//  Created by Natalie Alvarez on 4/15/24.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _flavor = "flavor"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zipCode = "zipCode"
    }

    // MARK: Cupcake
    static let flavors = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var flavor = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    // MARK: Address
    var name = ""
    var streetAddress = ""
    var city = ""
    var zipCode = ""

    var hasValidAddress: Bool {
        if isWhiteSpaceOrEmpty(name) || isWhiteSpaceOrEmpty(streetAddress) || isWhiteSpaceOrEmpty(city) || isWhiteSpaceOrEmpty(zipCode) {
            return false
        }

        return true
    }

    func isWhiteSpaceOrEmpty(_ str: String) -> Bool {
        return str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: Check Out
    var cost: Decimal {
        // base price ($2 per cupcake)
        var cost = Decimal(quantity) * 2

        // complicated cupcakes cost more
        cost += Decimal(flavor) / 2

        // extra frosting ($1 per cupcake)
        if extraFrosting {
            cost += Decimal(quantity) * 1
        }

        // sprinkles ($0.50 per cupcake)
        if addSprinkles {
            cost += Decimal(quantity) * 0.50
        }

        return cost
    }
}
