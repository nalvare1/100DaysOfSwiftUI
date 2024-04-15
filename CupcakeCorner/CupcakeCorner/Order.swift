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
        case _flavorIndex = "flavorIndex"
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

    var flavorIndex = 0
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
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zipCode.isEmpty {
            return false
        }

        return true
    }

    // MARK: Check Out
    var cost: Double {
        // base price ($2 per cupcake)
        var cost = Decimal(quantity) * 2

        // complicated cupcakes cost more
        cost += Decimal(flavorIndex) / 2

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
