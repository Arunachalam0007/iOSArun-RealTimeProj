//
//  KartInfoTableViewController.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

class KartInfoTableViewController: UITableViewController {
    
    // MARK: - Properties

    var kartVM: KartViewModel?
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helper
    
    func configureUI(){
        navigationItem.title = "Your Kart"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
        tableView.register(UINib(nibName: Constants.Kart.kartNibName, bundle: nil), forCellReuseIdentifier: Constants.Kart.kartCellIdentifier)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kartVM?.filterdKartData.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KartCellIdentifier", for: indexPath) as! KartCell
        let kartData = kartVM?.filterdKartData[indexPath.row]
        if let storageName = kartData?.storage_name, let quality = kartData?.quantity {
            cell.productName.text = storageName
            cell.quantityValue.text = String(quality)
            cell.productImage.image = UIImage(named: storageName)
            cell.accessoryType = .none
            cell.quantityValue.isEnabled = false
        }
        return cell
    }
    
    // MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
}
