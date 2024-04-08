//
//  MissionView.swift
//  Moonshot
//
//  Created by Natalie Alvarez on 3/26/24.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let crew: [CrewMember]

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }

                Text(mission.formattedLaunchDate)
                    .titleStyle()

                VStack(alignment: .leading) {
                    DividerView()

                    Text("Mission Highlights")
                        .titleStyle()

                    Text(mission.description)

                    DividerView()

                    Text("Crew")
                        .titleStyle()
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id:\.role) { crewMember in
                            NavigationLink {
                                AstronautDetailView(astronaut: crewMember.astronaut)
                            } label: {
                                AstronautLinkView(crewMember: crewMember)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { crewMember in
            if let astronaut = astronauts[crewMember.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing crew member: \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(missions[0])
        .preferredColorScheme(.dark)
}
