//
//  Mission.swift
//  Moonshot
//
//  Created by Taha Darwish on 29/12/2023.
//

import Foundation

struct Mission: Codable , Identifiable {
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

struct Crew: Codable {
    let name, role: String
}
