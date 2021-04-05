//
//  ViewController.swift
//  Sha-GoogleMap-Routes
//
//  Created by ArunSha on 05/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tab: UITableView!
    
    var sourceRoutes = [String]()
    var destinationRoutes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tab.dataSource = self
        tab.delegate = self
        getSourceAndDestination()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Get All Source and Destination from PLIST

    
    func getSourceAndDestination() {
        if let path = Bundle.main.path(forResource: "SourceAndDestination", ofType: "plist") {
            let dict = NSDictionary(contentsOfFile: path)
            if let rootDict = dict as? [String:Any], let rootDirections = rootDict["Directions"] as? [Any] {
                for direction in rootDirections  {
                    if let sourceAndDestination = direction as? [String:String] , let source = sourceAndDestination["source"], let destinaton = sourceAndDestination["destination"]  {
                        sourceRoutes.append(source)
                        destinationRoutes.append(destinaton)
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource for Create Rows


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sourceRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TabCell",for: indexPath) as! SourceDestinationTableViewCell
        cell.sourceLabel.text = sourceRoutes[indexPath.item]
        cell.destinationLabel.text = destinationRoutes[indexPath.item]
        cell.routeImage.image = UIImage(systemName: "location.fill")
        cell.routeImage.tintColor = .red
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate performing delegaet operation and segue


extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShaMapView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gMapVC = segue.destination as! GoogleMapViewController
        if let indexPath = self.tab.indexPathForSelectedRow?.item {
            gMapVC.sourceLocation = sourceRoutes[indexPath]
            gMapVC.destinationLocation = destinationRoutes[indexPath]
            gMapVC.apiKey = "AIzaSyAqlEbVFW9gPe0_sqsIYd5lw3-9uUfG5A4"
        }
    }
    
}
