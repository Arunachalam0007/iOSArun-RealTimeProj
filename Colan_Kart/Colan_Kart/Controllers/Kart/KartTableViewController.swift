//
//  KartTableViewController.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

class KartTableViewController: UITableViewController {
    
    // MARK: - Properties

    let kartVM = KartViewModel()
    
    @IBAction func checkKart(_ sender: UIBarButtonItem) {
        
        let kartInfoVC = KartInfoTableViewController()
        kartInfoVC.kartVM = kartVM
        navigationController?.pushViewController(kartInfoVC, animated: true)
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        kartVM.loadKartData()
        configureUI()
    }
    
    // MARK: - Helpers

    func configureUI() {
        tableView.register(UINib(nibName: Constants.Kart.kartNibName, bundle: nil), forCellReuseIdentifier: Constants.Kart.kartCellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return kartVM.kartModel?.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Kart.kartCellIdentifier, for: indexPath) as! KartCell
        let kartData = kartVM.kartModel?.data?[indexPath.row]
        if let storageName = kartData?.storage_name, let quantity = kartData?.quantity {
            cell.productName.text = storageName
            cell.quantityValue.text = String(quantity)
            cell.productImage.image = UIImage(named: storageName)
            cell.accessoryType = .none
            cell.stepper.isHidden = false
        }
        return cell
    }
    
    // MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let cell =  tableView.cellForRow(at: indexPath) as! KartCell
        let qualityStirng = cell.quantityValue.text
        if cell.accessoryType == .checkmark && !kartVM.filterdKartData.isEmpty {
            cell.accessoryType = .none
            kartVM.filterdKartData = kartVM.filterdKartData.filter({ kartData in
                if kartData.storage_name ==  cell.productName.text {
                    return false
                }
                return true
            })
        } else if Int(qualityStirng!)! > 0 {
            cell.accessoryType = .checkmark
            kartVM.filterdKartData.append(KartData( id: indexPath.item, storage_name: cell.productName.text, quantity: Int(qualityStirng!) ))
        }
    }
    

}
