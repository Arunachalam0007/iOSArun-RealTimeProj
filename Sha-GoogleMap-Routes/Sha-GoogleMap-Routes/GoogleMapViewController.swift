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
    
//
//    @IBOutlet weak var googleMapView: GMSMapView!
    
    
    @IBOutlet weak var googleMapView: GMSMapView!
 
    var sourceLocation:String = "Tambaram"
    var destinationLocation:String = "Madurai"
    var apiKey:String = "AIzaSyAqlEbVFW9gPe0_sqsIYd5lw3-9uUfG5A4"
    var sourceLatitude:Double = 0.0
    var sourceLongitude:Double = 0.0
    var destinationLatitude:Double = 0.0
    var destinationLongitude:Double = 0.0
    var polyLinePoints:String = ""
    
   
    
    
    func getMapAPIURL() -> String {
        let mapURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&key=\(apiKey)"
        return mapURL
    }
    
    func getRoute() {
        let mapAPIURL = getMapAPIURL()
        print("API KEY: ",mapAPIURL)
        
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
                    
                    // Get Souce and Destination lat & Lng Values
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
    
    func setGMSPolyLine() {
        let gmsPath = GMSPath.init(fromEncodedPath: polyLinePoints)
        let polyLine = GMSPolyline.init(path: gmsPath)
        polyLine.strokeWidth = 4
        polyLine.strokeColor = .blue
        polyLine.map = self.googleMapView
    }
    
    func setGSMMarker() {
        print("Source Lat",sourceLatitude," Long",sourceLongitude)
        print("Destination Lat",destinationLatitude," Long",destinationLongitude)
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
    
    func setCamerPostition(sourceMarker: GMSMarker) {
        let camera = GMSCameraPosition(target: sourceMarker.position, zoom: 10.5)
        googleMapView.animate(to: camera)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRoute();
        
    }
    

}
