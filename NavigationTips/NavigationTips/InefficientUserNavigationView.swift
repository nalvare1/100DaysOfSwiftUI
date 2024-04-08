//
//  InefficientView.swift
//  NavigationTips
//
//  Created by Natalie Alvarez on 3/28/24.
//

import SwiftUI

struct SimpleDetailView1: View {
    var number: Int

    var body: some View {
        Text("Detail View \(number)")
    }

    init(number: Int) {
        self.number = number
        print("Creating Detail View with number: \(number)")
    }
}

// Inefficient solution: just using a NavigationLink
struct InefficientView: View {
    var body: some View {
        NavigationStack {
            // This causes our view to create/initialize EACH DetailView (100 views!) once InefficientView is loaded, instead of just the DetailView that we actually need when we tap
            List(0..<100) { i in
                NavigationLink("Tap Me") {
                    SimpleDetailView1(number: i)
                }
            }
        }
    }
}

#Preview {
    InefficientView()
}
