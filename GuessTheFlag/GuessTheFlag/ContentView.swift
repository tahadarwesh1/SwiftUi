//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Taha Darwish on 15/12/2023.
//

import SwiftUI

struct FlagImage: View {
    var image : String
    var body: some View {
        Image(image)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle.bold())
    }
}

extension View {
    func titleModifier() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctedAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showScore = false
    @State private var score = 0
    @State private var currentQuestion = 1
    @State private var showEndDialog = false
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3) ,
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.30)]
                , center: .top, startRadius: 200, endRadius: 700)
            VStack {
                Spacer()
                Text("Gess The Flag")
                    .titleModifier()
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctedAnswer])
                            .titleModifier()
                    }
                    ForEach(0..<3){ number in
                        Button
                        {
                         flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(Rectangle())
                .cornerRadius(20)
                Spacer()
                Spacer()
                Text("Score: \(score) / 8")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }.padding(20)
            
            .alert(scoreTitle , isPresented: $showScore){
                Button(currentQuestion != 8 ? "Continue" : "Restart" ,action: currentQuestion != 8 ? askQuestion : restartGame)
            } message: {
                Text("Your score is \(score) / 8")
            }
        }
        .ignoresSafeArea()
    }
    func flagTapped(_ number : Int){
        if(number == correctedAnswer) {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[correctedAnswer])"
        }
        showScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctedAnswer = Int.random(in: 0...2)
        currentQuestion += 1
    }
    func restartGame(){
        countries.shuffle()
        correctedAnswer = Int.random(in: 0...2)
        currentQuestion = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
