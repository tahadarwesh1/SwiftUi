//
//  MissionView.swift
//  Moonshot
//
//  Created by Taha Darwish on 30/12/2023.
//

import SwiftUI

struct MissionView: View {
    
    let mission : Mission
    let crew : [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.bottom)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Launch Date:")
                        Text(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A")
                    }
                    AppDivider()
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom)
                    Text(mission.description)
                        .padding(.bottom)
                    AppDivider()
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom)
                }
                .padding(.horizontal)
                
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
                                            Circle().strokeBorder(.white , lineWidth: 1)
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
            .padding(.bottom)
            
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackGround)
    
    }
    init(mission: Mission, astronauts: [String : Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
              return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions : [Mission] = Bundle.main.decode(file: "missions.json")
    let astronauts : [String : Astronaut] = Bundle.main.decode(file: "astronauts.json")
   return MissionView(mission: missions[2] , astronauts: astronauts)
        .preferredColorScheme(.dark)
}
