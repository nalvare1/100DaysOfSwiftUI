//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Natalie Alvarez on 5/1/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
