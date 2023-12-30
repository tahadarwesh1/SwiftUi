//
//  ContentView.swift
//  Moonshot
//
//  Created by Taha Darwish on 27/12/2023.
//

import SwiftUI

struct ContentView: View {
    let astronauts : [String:Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions : [Mission] = Bundle.main.decode(file: "missions.json")
    
    @State private var showingGrid = true
    var body: some View {
        NavigationStack {
            ScrollView {
                if showingGrid {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("MoonShot")
            .background(.darkBackGround)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label : {
                    showingGrid ?
                    Image(systemName: "list.bullet")
                        .foregroundStyle(.white)
                    : Image(systemName: "squareshape.split.2x2")
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
