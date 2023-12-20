//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Taha Darwish on 20/12/2023.
//

import SwiftUI

struct ImageView : View {
    var image : String
    var width : CGFloat
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: width)
    }
}

struct ContentView: View {
    @State private var optionsImages = ["rock" ,"paper" , "scissor"]
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var currentRound = 1
    @State private var currentImage = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var showDialog = false
    @State private var isFinished = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red,.pink,.purple,.blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 25) {
                Text("Rock Paper Scissor")
                    .font(.largeTitle.bold())
                    .foregroundColor(.yellow)
                ImageView(image: optionsImages[currentImage] ,width: 200)
                HStack {
                    Text("How to")
                    Text(shouldWin ? "win" : "lose")
                        .foregroundColor(shouldWin ? .green : .red)
                    Text("this round?")
                }.font(.title2.bold())
                HStack(spacing: 25) {
                    ForEach(0..<3) { image in
                        Button {
                            choiceTapped(image)
                        } label: {
                            ImageView(image: optionsImages[image],width: 70)
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(16)
                        }
                    }
                }.alert(scoreTitle,isPresented: $showDialog) {
                    Button(isFinished ? "Restart" : "Continue", action: isFinished ? restartGame : nextQuestion)
                }
                Text("Round: \(currentRound) / 10")
                    .font(.title.bold())
                Text("Score: \(score)")
                    .font(.title2.bold())
            }
        }
    }
    
    func nextQuestion() {
        if(currentRound != 10){
            optionsImages.shuffle()
            currentImage = Int.random(in: 0...2)
            shouldWin = Bool.random()
        } else {
            isFinished = true
        }
    }
    func moveResult(_ playerPick: Int) {
            if playerPick == currentImage {
                scoreTitle = "Draw"
                score = score
            }
            let winningMoves = [1, 2, 0] // paper, scissor, rock
            let didWin: Bool
            
            if shouldWin {
                didWin = playerPick == winningMoves[currentImage]
            } else {
                didWin = currentImage == winningMoves[playerPick]
            }
        
        if didWin {
            scoreTitle = "correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        }
    func choiceTapped(_ number: Int) {
            moveResult(number)
            // to avoid negative score
            score = score < 0 ? 0 : score
            currentRound += 1
            showDialog = true
        }
    func restartGame() {
            shouldWin = Bool.random()
            currentImage = Int.random(in: 0...2)
            score = 0
            currentRound = 1
            isFinished = false
        }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
