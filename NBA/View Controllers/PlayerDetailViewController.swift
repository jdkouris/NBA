//
//  PlayerDetailViewController.swift
//  NBA
//
//  Created by John Kouris on 10/8/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var teamNameLabel: UILabel!
    @IBOutlet var conferenceLabel: UILabel!
    @IBOutlet var divisionLabel: UILabel!
    
    var apiController: APIController?
    var player: Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        updateViews()
    }
    
    func updateViews() {
        guard let player = player else { return }
        
        nameLabel.text = "\(player.firstName) \(player.lastName)"
        if player.position == "" {
            positionLabel.text = "Unknown position"
        } else {
            positionLabel.text = "Position: \(player.position)"
        }
        teamNameLabel.text = player.team.fullName
        conferenceLabel.text = "Conference: \(player.team.conference)"
        divisionLabel.text = "Division: \(player.team.division)"
    }
    
}
