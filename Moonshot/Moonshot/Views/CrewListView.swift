//
//  CrewListView.swift
//  Moonshot
//
//  Created by Taha Darwish on 30/12/2023.
//

import SwiftUI

struct CrewListView: View {
    let missionsFlown : [Mission]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew , id: \.role){ member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .frame(width: 90 ,height: 90)
                                .clipShape(.circle)
                                .overlay(
                                    Circle().stroke()
                                )
                            VStack (alignment:.leading){
                                Text(member.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)
                            Text(member.role)
                                .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    init(astronaut: Astronaut, missionsFlown: [Mission]) {
            self.astronaut = astronaut

            var matches = [Mission]()

            for mission in missions {
                if mission.crew.contains(where: { $0.name == astronaut.id }) {
                    matches.append(mission)
                }
            }
            self.missionsFlown = matches
        }
}

#Preview {
    let missions : [Mission] = Bundle.main.decode(file: "missions.json")
    let astronauts : [String : Astronaut] = Bundle.main.decode(file: "astronauts.json")
    return CrewListView(mission: missions[1], astronauts: astronauts)
}
