//
//  ContentView.swift
//  Bookworm
//
//  Created by Natalie Alvarez on 4/24/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //@Query(sort: \Book.rating, order: .reverse) var books: [Book]
    @Query(sort: [
        SortDescriptor(\Book.title), // sort by title
        SortDescriptor(\Book.author) // then author
    ]) var books: [Book]

    @State private var showingAddBook = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    HStack {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)

                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                                .fontWeight(book.rating == 5 ? .bold : .regular)
                                .foregroundColor(book.rating == 5 ? .green : .primary)

                            Text(book.author)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddBook.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddBook, content: {
                AddBookView()
            })
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
