//
//  GoogleMapViewController.swift
//  Sha-GoogleMap-Routes
//
//  Created by ArunSha on 05/04/21.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class GoogleMapViewController: UIViewController {
    
    var sourceLocation:String = ""
    var destinationLocation:String = ""
    var apiKey:String = ""
    var sourceLatitude:Double = 0.0
    var sourceLongitude:Double = 0.0
    var destinationLatitude:Double = 0.0
    var destinationLongitude:Double = 0.0
    
    @IBOutlet var googleMapView: GMSMapView!
    
    func getMapAPIURL() -> String {
        let mapURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&key=\(apiKey)"
        return mapURL
    }
    
    func setRoute(mapAPIURL:String) {
        
        AF.request(mapAPIURL).responseJSON { (response) in
            guard let responseData = response.data else {
                return
            }
            print("responData: ",responseData)
            do{
                let responseJSONData = try JSON(data: responseData)
                print("responseJSONData: ",responseJSONData)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func setGSMMarker() {
        
        let sourceMaker = GMSMarker()
        let destinationMaker = GMSMarker()
        
        sourceMaker.position = CLLocationCoordinate2D(latitude: Double(sourceLatitude), longitude: sourceLongitude)
        sourceMaker.title = sourceLocation
        sourceMaker.map = googleMapView
        
        destinationMaker.position = CLLocationCoordinate2D(latitude: Double(destinationLatitude), longitude: destinationLongitude)
        destinationMaker.title = destinationLocation
        destinationMaker.map = googleMapView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
