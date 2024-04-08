//
//  ProgrammaticNavigationView1.swift
//  NavigationTips
//
//  Created by Natalie Alvarez on 3/28/24.
//

import SwiftUI

// Efficient: programmatic navigation using a NavigationStack
struct ProgrammaticNavigationView1: View {
    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Show 32") {
                    path = [32]
                }
                Button("Show 64") {
                    path.append(64)
                }

                Button("Show 32, then 64") {
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self) { selectedInt in
                Text("You selected \(selectedInt)")
            }
        }
    }
}

#Preview {
    ProgrammaticNavigationView1()
}
