//
//  ContentView.swift
//  TimesTable
//
//  Created by Taha Darwish on 24/12/2023.
//

import SwiftUI

struct SectionTitleModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.black)
            .bold()
    }
}

struct ContentView: View {
    @State private var timeTable = 2
    @State private var numOfQuestions = 1
    @State private var isShowingDetailView = false
    var body: some View {
        NavigationStack {
            List {
                Section("Choose your time table") {
                    HStack {
                        Text("\(timeTable)")
                            .foregroundColor(.black)
                        Spacer()
                        Stepper("", value: $timeTable, in: 2...12)
                    }
                }
                .modifier(SectionTitleModifier())
                Section("How many question") {
                    Picker("\(numOfQuestions * 5)", selection: $numOfQuestions){
                        ForEach(1..<6 , id: \.self){ number in
                             Text("\(number * 5)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .modifier(SectionTitleModifier())
                
                HStack {
                    Spacer()
                    Button("Generate") {
                       print("taha")
                        isShowingDetailView = true

                    }
                    .listRowBackground(Color.clear)
                    .frame(width: 150,height: 50)
                    .foregroundColor(.white)
                    .background(.blue)
                    Spacer()
                }
                .listRowBackground(Color.clear)
                }
            .navigationDestination(isPresented: $isShowingDetailView) {
                QuestionsView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
