//
//  KartTableViewController.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

class KartTableViewController: UITableViewController {
    
    // MARK: - Properties


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers

    func configureUI() {
        tableView.register(UINib(nibName: Constants.Kart.kartNibName, bundle: nil), forCellReuseIdentifier: Constants.Kart.kartCellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Kart.kartCellIdentifier, for: indexPath) as! KartCell
        cell.kartName.text = "HEELO"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

}
