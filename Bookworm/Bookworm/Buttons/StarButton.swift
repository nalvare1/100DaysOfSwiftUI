//
//  StarButtonView.swift
//  Bookworm
//
//  Created by Natalie Alvarez on 4/25/24.
//

import SwiftUI

struct StarButtonView: View {
    @Binding var rating: Int
    var star: Int

    var offImage: Image?
    var starImage = Image(systemName: "star.fill")

    var greyStarColor = Color.gray
    var yellowStarColor = Color.yellow


    var body: some View {
        Button {
            rating = star
        } label: {
            starImage(for: star)
                .foregroundStyle(star > rating ? greyStarColor : yellowStarColor)
        }
        .buttonStyle(.plain) // Treat each button in the row as an individual button
    }

    func starImage(for star: Int) -> Image {
        if star > rating {
            offImage ?? starImage
        } else {
            starImage
        }
    }
}

struct StarButtonStyle: ButtonStyle {
    @Binding var rating: Int
    var star: Int

    var offImage: Image?
    var starImage = Image(systemName: "star.fill")

    var greyStarColor = Color.gray
    var yellowStarColor = Color.yellow

    func makeBody(configuration: Configuration) -> some View {
        starImage(for: star)
            .foregroundStyle(star > rating ? greyStarColor : yellowStarColor)
            .buttonStyle(.plain) // Treat each button in the row as an individual button
    }

    func starImage(for star: Int) -> Image {
        if star > rating {
            offImage ?? starImage
        } else {
            starImage
        }
    }
}
