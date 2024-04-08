//
//  AstronautDetailView.swift
//  Moonshot
//
//  Created by Natalie Alvarez on 3/27/24.
//

import SwiftUI

struct AstronautDetailView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    AstronautDetailView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
