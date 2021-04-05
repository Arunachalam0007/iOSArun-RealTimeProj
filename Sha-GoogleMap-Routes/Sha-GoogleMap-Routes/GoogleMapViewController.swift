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
    

    @IBOutlet weak var googleMapView: GMSMapView!
 
    var sourceLocation:String = ""
    var destinationLocation:String = ""
    var apiKey:String = ""
    var sourceLatitude:Double = 0.0
    var sourceLongitude:Double = 0.0
    var destinationLatitude:Double = 0.0
    var destinationLongitude:Double = 0.0
    var polyLinePoints:String = ""
    
   
    // MARK: - GetMapApi

    
    func getMapAPIURL() -> String {
        let mapURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&key=\(apiKey)"
        return mapURL
    }
    
    // MARK: - GetRoute

    
    func getRoute() {
        let mapAPIURL = getMapAPIURL()
        
        AF.request(mapAPIURL).responseJSON { (response) in
            guard let responseData = response.data else {
                return
            }
            do{
                // Convert Bytes to JSON
                let responseJSONData = try JSON(data: responseData)
                let routes = responseJSONData["routes"].arrayValue
                
                for route in routes {
                    
                    let legs = route["legs"].arrayValue
                    
                    // Get Source and Destination lat & Lng Values
                    for leg in legs {
                        let startLocation = leg["start_location"].dictionary
                        let endLocation = leg["end_location"].dictionary
                       
                        if let sourceLat = startLocation?["lat"]?.double, let sourceLong = startLocation?["lng"]?.double{
                            self.sourceLatitude = sourceLat
                            self.sourceLongitude = sourceLong
                        }
                        if let destinationLat = endLocation?["lat"]?.double, let destinationLong = endLocation?["lng"]?.double{
                            self.destinationLatitude = destinationLat
                            self.destinationLongitude = destinationLong
                        }
                    }
                    
                    // get Polyline Points
                    let overviewPolyline = route["overview_polyline"].dictionary
                    if let points = overviewPolyline?["points"]?.string {
                        self.polyLinePoints = points
                    }
                }
               // create a polyline for source and destination with use of polyLinePoints
               self.setGMSPolyLine()
               // Create a Marker for source and destination
               self.setGSMMarker()
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    // MARK: - SetGMSPolyLine: Points source and destination

    
    func setGMSPolyLine() {
        let gmsPath = GMSPath.init(fromEncodedPath: polyLinePoints)
        let polyLine = GMSPolyline.init(path: gmsPath)
        polyLine.strokeWidth = 4
        polyLine.strokeColor = .blue
        polyLine.map = self.googleMapView
    }
    
    // MARK: - setGSMMarker: create source and destination marker

    
    func setGSMMarker() {
        let sourceMaker = GMSMarker()
        let destinationMaker = GMSMarker()
        
        sourceMaker.position = CLLocationCoordinate2D(latitude: sourceLatitude, longitude: sourceLongitude)
        sourceMaker.title = sourceLocation
        sourceMaker.map = self.googleMapView
        
        destinationMaker.position = CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude)
        destinationMaker.title = destinationLocation
        destinationMaker.map = self.googleMapView
        
        // Set the camera position to the source and destination
        setCamerPostition(sourceMarker: sourceMaker)
    }
    
    // MARK: - GMSCameraPosition: Which will automationally animate to source and destination

    
    func setCamerPostition(sourceMarker: GMSMarker) {
        let camera = GMSCameraPosition(target: sourceMarker.position, zoom: 10.5)
        googleMapView.animate(to: camera)
    }
    
    // MARK: - Updating Nav Title

    
    func updateNavTitle() {
        var charIndex = 0.0
        let labelText = "🧭Sha Google Map Routes🧭"
        title = ""
        for text in labelText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { (timer) in
                self.title?.append(text)
            }
            charIndex += 1

        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavTitle()
        getRoute();
    }
    

}
