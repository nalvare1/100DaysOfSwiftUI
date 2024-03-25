//
//  ContentView.swift
//  WordScramble
//
//  Created by Natalie Alvarez on 2/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    @State private var score = 0

    var body: some View {
        NavigationStack {
            List {
                // Add new word:
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }

                // List of used words:
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }

                // Score - Day 31:
                Section(header: Text("Score")) {
                    Text("\(score)")
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            // Day 31:
            .toolbar {
                Button("New Game", action: startGame)
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard isNotEmpty(word: answer) else { return }

        guard isNotTooShort(word: answer) else {
            wordError(title: "Word is too short", message: "Your word must have at least 3 letters!")
            return
        }

        guard isNotRootWord(word: answer) else {
            wordError(title: "Word is root word", message: "You can't just use the question as the answer!")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        // add answer to the top of the list of usedWords:
        withAnimation {
            usedWords.insert(answer, at: 0)
            calculateScore(word: answer)
        }
        newWord = ""
    }

    func startGame() {
        score = 0
        usedWords = []

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }

        fatalError("Could not load start.txt from bundle.")
    }

    // Original Solution - Day 30:
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                // letter is not found in word:
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    // Challenge Solution - Day 31:
    func isNotEmpty(word: String) -> Bool {
        return word.count != 0
    }

    func isNotTooShort(word: String) -> Bool {
        return word.count >= 3
    }

    func isNotRootWord(word: String) -> Bool {
        return word != rootWord
    }

    func calculateScore(word: String) {
        score += word.count
    }
}

#Preview {
    ContentView()
}
