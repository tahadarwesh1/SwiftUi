//
//  AstronautView.swift
//  Moonshot
//
//  Created by Taha Darwish on 30/12/2023.
//

import SwiftUI

struct AstronautView: View {
    let astronaut : Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
//                    .foregroundStyle(.white)
                    .padding()
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackGround)
    }
}

#Preview {
    let astronauts : [String:Astronaut] = Bundle.main.decode(file: "astronauts.json")
    return AstronautView(astronaut: astronauts["white"]!)
        .preferredColorScheme(.dark)
}
