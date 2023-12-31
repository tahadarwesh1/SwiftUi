//
//  CrewMember.swift
//  Moonshot
//
//  Created by Taha Darwish on 30/12/2023.
//

import Foundation

struct CrewMember : Codable , Hashable{
    static func == (lhs: CrewMember, rhs: CrewMember) -> Bool {
       return lhs.astronaut == rhs.astronaut
        && lhs.role == rhs.role
    }
    
    let role : String
    let astronaut : Astronaut
}
