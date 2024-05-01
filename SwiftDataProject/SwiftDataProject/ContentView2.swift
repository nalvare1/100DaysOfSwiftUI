//
//  ContentView2.swift
//  SwiftDataProject
//
//  Created by Natalie Alvarez on 5/1/24.
//

import SwiftData
import SwiftUI

struct ContentView2: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<User> { user in
            //user.name.contains("R") // contains() is case sensitive (this only matches uppercase "R"s)
            user.name.localizedStandardContains("R") && // is not case sensitive
            user.city == "London"
        }, sort: \User.name) var users: [User]

    var body: some View {
        NavigationStack() {
            List(users) { user in
                Text(user.name)
            }
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self) // delete all existing users before

                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10)) // 10 days ago
                    let second = User(name: "Rosa Diaz", city: "New Yrok", joinDate: .now.addingTimeInterval(86400 * -5)) // 5 days ago
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5)) // 5 days from now
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10)) // 10 days from now

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}


#Preview {
    ContentView2()
}
