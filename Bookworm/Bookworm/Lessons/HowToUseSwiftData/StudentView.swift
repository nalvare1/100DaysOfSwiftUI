//
//  StudentView.swift
//  Bookworm
//
//  Created by Natalie Alvarez on 4/24/24.
//

import SwiftData
import SwiftUI

struct StudentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student] // With @Query, SwiftData is able to find our data in the modelContainer

    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!

                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(student)
                }
            }
        }
    }
}

#Preview {
    StudentView()
}
