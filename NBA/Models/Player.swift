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
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case position
    }
}

struct PlayerSearch: Codable {
    let data: [Player]
}
