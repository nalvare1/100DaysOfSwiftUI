//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Natalie Alvarez on 11/7/23.
//

import SwiftUI

struct FlagImage: View {
    var countryName: String

    var body: some View {
        Image(countryName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var scoreRight = 0
    @State private var scoreWrong = 0
    @State private var scoreTitle = ""
    @State private var scoreIsShowing = false
    @State private var gameOver = false

    var score: String {
        "\(scoreRight) right\n\(scoreWrong) wrong"
    }

    var gamesPlayed: Int {
        scoreRight + scoreWrong
    }

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { option in
                        Button {
                            flagTapped(option)
                        } label: {
                            FlagImage(countryName: countries[option]) // Day 24
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score:\n\(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()


        }
        .alert(scoreTitle, isPresented: $scoreIsShowing) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is\n\(score)")
        }
        .alert(scoreTitle, isPresented: $gameOver) {
            Button("Play Again", action: restartGame)
        } message: {
            Text("Your final score is\n\(score)")
        }
    }

    func flagTapped(_ option: Int) {
        if (option == correctAnswer) {
            scoreRight += 1
            scoreTitle = "Correct"
        } else {
            scoreWrong += 1
            scoreTitle = "Wrong! That's the flag of \(countries[option])"
        }

        scoreIsShowing = true

        if (gamesPlayed >= 3) {
            gameOver = true
            scoreIsShowing = false
        } else {
            scoreIsShowing = true
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func restartGame() {
        scoreRight = 0
        scoreWrong = 0

        gameOver = false
        askQuestion()
    }
}

#Preview {
    ContentView()
}
