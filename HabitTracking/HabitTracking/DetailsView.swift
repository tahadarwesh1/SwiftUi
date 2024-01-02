//
//  DetailsView.swift
//  HabitTracking
//
//  Created by Taha Darwish on 02/01/2024.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State var habit : HabitItem
    var habits : Habits
    var body: some View {
        Form {
            Section("Description") {
                TextField("description", text: $habit.description , axis: .vertical)
            }
            Section("Amount") {
                Stepper("Completes: \(habit.amount)", value: $habit.amount)
            }
        }
        .navigationTitle($habit.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save"){
                    editHabit()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel"){
                    dismiss()
                }
            }
        }
    }
    
    func editHabit() {
        let habitIndex = habits.habits.firstIndex(of: habit) ?? 0
        let newHabitItem = HabitItem(name: habit.name, description: habit.description, amount: habit.amount)
        habits.habits[habitIndex] = newHabitItem
        dismiss()
    }
}

#Preview {
    DetailsView(habit: HabitItem(name: "Test", description: "This is a description test", amount: 5),habits: Habits())
}
