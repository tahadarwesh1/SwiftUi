//
//  ListLayout.swift
//  Moonshot
//
//  Created by Taha Darwish on 30/12/2023.
//

import SwiftUI

struct ListLayout: View {
    let missions : [Mission]
    let astronauts : [String:Astronaut]
    
    var body: some View {
        ForEach(missions){ mission in
            NavigationLink {
                MissionView(mission: mission , astronauts: astronauts)
            } label: {
                HStack {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:100 , height: 100)
                            .padding()
                    }
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity,maxHeight:.infinity)
                    .background(.lightBackGround)
                }
                .frame(maxWidth: .infinity, maxHeight:.infinity)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackGround))
            }
        }
        .padding([.horizontal , .bottom])
    }
}

#Preview {
    let astronauts : [String:Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions : [Mission] = Bundle.main.decode(file: "missions.json")
    return ListLayout(missions: missions, astronauts: astronauts)}
