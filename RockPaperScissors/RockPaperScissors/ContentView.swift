//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Natalie Alvarez on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    var moves: [String: String] = ["rock": "🪨", "paper": "📜", "scissors": "✂️"]
    var moveChoice: [String] = ["rock", "paper", "scissors"]

    @State private var computerMoveInt: Int = Int.random(in: 0...2)
    @State private var shouldWin: Bool = Bool.random()
    @State private var scoreRight = 0
    @State private var scoreWrong = 0


    var computerMove: String {
        moveChoice[computerMoveInt]
    }

    var computerImage: String {
        moves[computerMove]!
    }

    var playerShouldWin: String {
        shouldWin ? "Win" : "Lose"
    }

    var score: String {
        "\(scoreRight) right\n\(scoreWrong) wrong"
    }

    var body: some View {
        VStack {
            Text("Rock, Paper, Scissors!")
                .font(.largeTitle.bold())
                .foregroundColor(.brown)

            Spacer()
            VStack {
                Text("Robot 🤖")
                    .font(.title)
                Text("chose")
                
                Text("\(computerImage)")
                    .font(.system(size: 100))
                Text("\(computerMove.capitalized)")
                    .italic()

                Text("")
                Text("and wants the player to")
                Text("\(playerShouldWin)")
                    .bold()
            }


            Spacer()

            VStack {
                Text("Player")
                    .font(.title)
                Text("please pick your move")

                HStack {
                    ForEach(Array(moves.keys), id: \.self) { key in
                        Button {
                            moveTapped(key)
                        } label: {
                            VStack {
                                Text(moves[key] ?? "")
                                    .font(.system(size: 100))
                                Text(key.capitalized)
                                    .italic()
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
            }

            Spacer()

            Text("Score:\n\(score)")
                .foregroundStyle(.brown)
        }
        .font(.title2)
        .padding()
    }

    func moveTapped(_ userAnswer: String) {
        var correctAnswer = ""

        if (shouldWin) {
            switch (computerMove) {
            case "rock":
                correctAnswer = "paper"
                break
            case "scissors":
                correctAnswer = "rock"
                break
            case "paper":
                correctAnswer = "scissors"
                break
            default:
                correctAnswer = "shoot"
            }
        } else {
            switch (computerMove) {
            case "rock":
                correctAnswer = "scissors"
                break
            case "scissors":
                correctAnswer = "paper"
                break
            case "paper":
                correctAnswer = "rock"
                break
            default:
                correctAnswer = "shoot"
            }
        }

        if (userAnswer == correctAnswer) {
            scoreRight += 1
        } else {
            scoreWrong += 1
        }

        askQuestion()
    }

    func askQuestion() {
        computerMoveInt = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
