//
//  HabitItem.swift
//  HabitTracking
//
//  Created by Taha Darwish on 01/01/2024.
//

import Foundation

struct HabitItem : Hashable , Codable , Equatable , Identifiable {
    var id  = UUID()
    var name , description : String
    var amount : Int
    var displayDescription : String {
        description.isEmpty ? "N/A" : description
    }
}

@Observable
class Habits {
    var habits : [HabitItem] {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    init() {
        if let savedItems =  UserDefaults.standard.data(forKey: "Habits") {
            if let decoded = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                habits = decoded
                return
            }
        }
        habits = []
    }
}
