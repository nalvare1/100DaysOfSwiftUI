//
//  ReturnToRootView1.swift
//  NavigationTips
//
//  Created by Natalie Alvarez on 4/2/24.
//

import SwiftUI

struct DetailView1: View {
    var number: Int
    //@Binding var path: [Int]
    @Binding var path: NavigationPath


    var body: some View {
        NavigationLink("Go to Random number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    // Returns to the home view (by clearing the array):
                    // path.removeAll()
                    // Or use a NavigationPath:
                    path = NavigationPath()
                }
            }
    }
}

struct MainView1: View {
    //@State private var path = [Int]()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            DetailView1(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView1(number: i, path: $path)
                }
        }
    }
}
