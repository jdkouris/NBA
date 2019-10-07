//
//  PlayersTableViewController.swift
//  NBA
//
//  Created by John Kouris on 10/7/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    let apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell else { return UITableViewCell() }

        cell.player = apiController.players[indexPath.row]

        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
