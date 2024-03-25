//
//  Animation5.swift
//  Animations
//
//  Created by Natalie Alvarez on 3/1/24.
//

import SwiftUI

// A gradient (yellow/red) rectangle that can be dragged across the screen.
struct Animation5: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    // implicit animation:
                    //.onEnded { _ in dragAmount = .zero }


                    // explicit animation:
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            dragAmount = .zero
                        }
                    }
            )
            // implicit animation:
            //.animation(.bouncy, value: dragAmount)
    }
}

// The letters of "Hello SwiftUI" text being dragged across the screen like a snake, and changing colors
struct Animation6: View {
    let letters = Array("Hello SwiftUI")

    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation}
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

#Preview {
    Animation5()
}

#Preview {
    Animation6()
}
