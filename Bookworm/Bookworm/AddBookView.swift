//
//  AddBookView.swift
//  Bookworm
//
//  Created by Natalie Alvarez on 4/25/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var disableSaveBook: Bool {
        return (title.isEmpty || author.isEmpty)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }

                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        saveBook(book: newBook)
                    }
                    .disabled(disableSaveBook)
                }
            }
            .navigationTitle("Add Book")
        }
    }

    func saveBook(book: Book) {
        modelContext.insert(book)
        dismiss()
    }
}

#Preview {
    AddBookView()
}
