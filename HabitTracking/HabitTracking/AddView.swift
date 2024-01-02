//
//  AddView.swift
//  HabitTracking
//
//  Created by Taha Darwish on 01/01/2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name : String = ""
    @State private var description : String = ""
    var hapits : Habits
    var body: some View {
        List {
            TextField("Name", text: $name)
            TextField("description", text: $description , axis: .vertical)
                .lineLimit(7)
        }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addHabit()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add new habit")
            .navigationBarBackButtonHidden()
    }
    func addHabit() {
        if name.isEmpty {
            return
        } else {
            let habit = HabitItem(name: name, description: description, amount: 0)
            hapits.habits.insert(habit, at: 0)
            dismiss()
        }
    }
}

#Preview {
    AddView(hapits: Habits())
}
