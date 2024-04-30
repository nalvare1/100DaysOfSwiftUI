//
//  Student.swift
//  Bookworm
//
//  Created by Natalie Alvarez on 4/24/24.
//

import Foundation
import SwiftData

@Model
class Student { // This class is called a SwiftData Model
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
