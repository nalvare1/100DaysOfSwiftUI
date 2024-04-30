//
//  StudentApp.swift
//  Bookworm
//
//  Created by Natalie Alvarez on 4/24/24.
//

import SwiftData
import SwiftUI

//@main
struct StudentApp: App {
    var body: some Scene {
        WindowGroup { // This tells SwiftUI that our app can be displayed in multiple windows (ex: on iPadOS, macOS, etc.)
            ContentView()
        }
        .modelContainer(for: Student.self) // modelContainer stores our data. The Model Context (which is created automatically) allows us to read data from memory (which is faster), and then save it later to the modelContainer
    }
}
