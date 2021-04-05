//
//  GoogleMapViewController.swift
//  Sha-GoogleMap-Routes
//
//  Created by ArunSha on 05/04/21.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController {
    
    var sourceLocation:String = ""
    var destinationLocation:String = ""
    var apiKey:String = ""
    
    @IBOutlet var googleMapView: GMSMapView!
    func getMapAPIURL() -> String {
        let mapURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&key=\(apiKey)"
        return mapURL
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
