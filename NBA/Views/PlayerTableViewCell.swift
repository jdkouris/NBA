//
//  PlayerTableViewCell.swift
//  NBA
//
//  Created by John Kouris on 10/7/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    
    var player: Player? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let player = player else { return }
        lastNameLabel.text = player.lastName
        firstNameLabel.text = player.firstName
        positionLabel.text = player.position
    }

}
