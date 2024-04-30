//
//  RatingView.swift
//  Bookworm
//
//  Created by Natalie Alvarez on 4/25/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var label = ""
    var maximumRating = 5

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1, id: \.self) { star in
                //StarButtonView(rating: $rating, star: star)
                Button(""){
                    rating = star
                }.buttonStyle(StarButtonStyle(rating: $rating, star: star))
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
