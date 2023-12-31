//
//  GridLayout.swift
//  Moonshot
//
//  Created by Taha Darwish on 30/12/2023.
//

import SwiftUI

struct GridLayout: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let missions : [Mission] 
    let astronauts : [String:Astronaut]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions){ mission in
                NavigationLink(value: mission) {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .padding()
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackGround)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackGround))
                    .navigationDestination(for: Mission.self) { mission in
                        MissionView(mission: mission , astronauts: astronauts)
                    }
                }
                
            }
        }
        .padding([.horizontal , .bottom])
    }
}

#Preview {
    let astronauts : [String:Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions : [Mission] = Bundle.main.decode(file: "missions.json")
    return GridLayout(missions: missions, astronauts: astronauts)
}
