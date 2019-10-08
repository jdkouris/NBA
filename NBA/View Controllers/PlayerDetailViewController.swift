//
//  PlayerDetailViewController.swift
//  NBA
//
//  Created by John Kouris on 10/8/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var teamNameLabel: UILabel!
    
    var apiController: APIController?
    var player: Player?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard let player = player else { return }
        lastNameLabel.text = player.lastName
        firstNameLabel.text = player.firstName
        if player.position == "" {
            positionLabel.text = "Unknown position"
        } else {
            positionLabel.text = "Position: \(player.position)"
        }
        
    }
    
}
