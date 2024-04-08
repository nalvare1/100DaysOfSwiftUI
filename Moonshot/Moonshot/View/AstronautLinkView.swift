//
//  AstronautLinkView.swift
//  Moonshot
//
//  Created by Natalie Alvarez on 3/27/24.
//

import SwiftUI

struct AstronautLinkView: View {
    let crewMember: CrewMember
    let astronaut: Astronaut
    let role: String

    var body: some View {
        HStack {
            Image(astronaut.id)
                .resizable()
                .frame(width: 104, height: 72 )
                .clipShape(.capsule)
                .overlay(
                    Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                )

            VStack(alignment: .leading) {
                Text(astronaut.name)
                    .foregroundStyle(.white)
                    .font(.headline)

                Text(role)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .padding(.horizontal)
    }

    init(crewMember: CrewMember) {
        self.astronaut = crewMember.astronaut
        self.role = crewMember.role
    }
}
