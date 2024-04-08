//
//  EfficientView.swift
//  NavigationTips
//
//  Created by Natalie Alvarez on 3/28/24.
//

import SwiftUI

// A struct must conform to Hashable to use NavigationLink and .navigationDestination()
struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

// Efficient solution: using a NavigationLink and .navigationDestination()
struct EfficientView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selectedInt in
                Text("You selected \(selectedInt)")
            }
            .navigationDestination(for: Student.self) { student in
                Text("You selected \(student.name)")
            }
        }
    }
}

#Preview {
    EfficientView()
}
