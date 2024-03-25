//
//  StartGameView.swift
//  Multiplication
//
//  Created by Natalie Alvarez on 3/5/24.
//

import SwiftUI

struct StartGameView: View {
    @State private var multiplicand: Int = 2
    @State private var numberOfQuestions: Int = 5

    // Multiplication:
    @State private var multiplier = Int.random(in: 1...12)
    var correctProduct: Int {
        multiplicand * multiplier
    }
    var question: String {
        "What is \(multiplicand) x \(multiplier)?"
    }
    @State private var answer = ""
    @State private var result = ""

    // Game state:
    //@State private var scoreRight = 0
    //@State private var scoreWrong = 0
    @State private var gameOver = true
    @State private var questionsAsked: Int = 0
//    var gamesPlayed: Int {
//        scoreRight + scoreWrong
//    }

    @State private var gameIsRunning: Bool = false

//    var playGame: Bool {
//        questionsAsked < numberOfQuestions
//    }

    @State private var showAnswer: Bool = false



    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                if gameIsRunning {
                    Text(question)

                    TextField("Type your answer here", text: $answer)
                        .padding()

                    Button("Enter") {
                        checkAnswer()
                    }
                } else {
                    List {
                        Section(header: Text("Which Times Tables?")) {
                            Stepper("\(multiplicand) Times Table", value: $multiplicand, in: 2...12)
                        }

                        Section(header: Text("How many questions?")) {
                            Stepper("\(numberOfQuestions) Questions", value: $numberOfQuestions, in: 5...15, step: 5)
                        }

                        Button("Start Game") {
                            gameOver = false
                            gameIsRunning = true
                        }
                    }

                }
            }
            .navigationTitle("Times Tables")
            .navigationBarTitleDisplayMode(.inline)
            .alert(result, isPresented: $showAnswer) {
                Button("Ok") {
                    showAnswer = false
                    askQuestion()
                }
            } message: {
                Text("Keep going!")
                //Text(gameIsRunning ? "Keep going!" : "Game Over")
            }
        }
    }

    func askQuestion() {
        multiplier = Int.random(in: 1...12)
        questionsAsked += 1

        if questionsAsked >= numberOfQuestions {
            gameIsRunning = false
        }
    }

    func checkAnswer() {
        guard let product = Int(answer) else {
            result = "Wrong answer! You must type in an integer."
            return
        }

        if product == correctProduct {
            result = "Right answer!"
        } else {
            result = "Wrong answer! The correct answer is \(correctProduct)"
        }

        showAnswer = true
    }
}

#Preview {
    StartGameView()
}
