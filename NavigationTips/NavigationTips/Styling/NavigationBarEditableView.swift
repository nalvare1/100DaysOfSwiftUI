//
//  NavigationBarEditableView.swift
//  NavigationTips
//
//  Created by Natalie Alvarez on 4/2/24.
//

import SwiftUI

struct NavigationBarEditableView: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Hello World")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
