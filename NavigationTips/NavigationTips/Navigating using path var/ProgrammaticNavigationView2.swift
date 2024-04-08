//
//  ProgrammaticNavigationView2.swift
//  NavigationTips
//
//  Created by Natalie Alvarez on 3/28/24.
//

import SwiftUI

// Efficient: programmatic navigation using a NavigationPath
struct ProgrammaticNavigationView2: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Selected Number: \(i)", value: i)
                }

                ForEach(0..<5) { i in
                    NavigationLink("Selected String: \(i)", value: String(i))
                }
            }
            .toolbar {
                Button("Push 556") {
                    path.append(556)
                }
                Button("Push Hello") {
                    path.append("Hello")
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
        }
    }
}

#Preview {
    ProgrammaticNavigationView2()
}
