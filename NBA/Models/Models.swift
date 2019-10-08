//
//  Player.swift
//  NBA
//
//  Created by John Kouris on 10/7/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation

struct Player: Codable {
    let firstName: String
    let lastName: String
    let position: String
    let team: Team
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case position
        case team
    }
}

struct Team: Codable {
    let conference: String
    let division: String
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case conference
        case division
        case fullName = "full_name"
    }
}

struct PlayerSearch: Codable {
    let data: [Player]
}
