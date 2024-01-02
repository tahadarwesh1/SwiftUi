//
//  ContentView.swift
//  HabitTracking
//
//  Created by Taha Darwish on 31/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var habits : Habits = Habits()
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits.habits , id: \.id) { item in
                    NavigationLink(value: item) {
                        Text(item.name)
                            .font(.headline)
                    }
                    .navigationDestination(for: HabitItem.self) {selection in
                        DetailsView(habit: selection, habits: habits)
                    }
                }
                .onDelete(perform:deleteHabit)
            }
            .navigationTitle("Habit")
            .toolbar {
                NavigationLink(destination: AddView(hapits: habits)){
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func deleteHabit(at offset : IndexSet) {
        habits.habits.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
