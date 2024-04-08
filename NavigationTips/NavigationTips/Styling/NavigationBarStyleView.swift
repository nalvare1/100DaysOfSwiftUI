//
//  NavigationBarStyleView.swift
//  NavigationTips
//
//  Created by Natalie Alvarez on 4/2/24.
//

import SwiftUI

struct NavigationBarStyleView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Cool nav bar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            //.toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    NavigationBarStyleView()
}
