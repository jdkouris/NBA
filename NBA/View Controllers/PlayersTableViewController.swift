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
        searchBar.delegate = self
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPlayerDetail" {
            guard let destinationVC = segue.destination as? PlayerDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.apiController = apiController
            destinationVC.player = apiController.players[indexPath.row]
        }
    }

}

extension PlayersTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let playerSearch = searchBar.text else { return }
        apiController.searchFor(player: playerSearch) { (result) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
