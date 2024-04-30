//
//  HowToUseTextEditorView.swift
//  Bookworm
//
//  Created by Natalie Alvarez on 4/24/24.
//

import SwiftUI

struct HowToUseTextEditorView: View {
    @AppStorage("notes") private var notes = "" // Do NOT use AppStorage to store private information!

    var body: some View {
        NavigationStack {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct HowToUseALargeHorizontalTextFieldView: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationStack {
            TextField("Enter your text", text: $notes) // This box grows horizontally as you type more into it (when you reach the end of the line)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct HowToUseALargeVerticalTextFieldView: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationStack {
            TextField("Enter your text", text: $notes, axis: .vertical) // This box grows vertically as you type more into it (every time you reach the end of the line)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

#Preview {
    HowToUseTextEditorView()
}

#Preview {
    HowToUseALargeHorizontalTextFieldView()
}

#Preview {
    HowToUseALargeVerticalTextFieldView()
}
