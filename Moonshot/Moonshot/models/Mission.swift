//
//  Mission.swift
//  Moonshot
//
//  Created by Taha Darwish on 29/12/2023.
//

import Foundation

struct Mission : Hashable, Codable , Identifiable , Equatable {
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id == rhs.id
            && lhs.launchDate == rhs.launchDate
            && lhs.crew == rhs.crew
            && lhs.description == rhs.description
    }
    
    let id: Int
    let crew: [Crew]
    let description: String
    let launchDate: Date?
    var displayName : String {
        "Apollo \(id)"
    }
    var image : String {
        "apollo\(id)"
    }
    var formattedLaunchDate : String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}

struct Crew: Codable, Hashable {
    let name, role: String
}
