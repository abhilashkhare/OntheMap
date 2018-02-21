//
//  UpdateLocationViewController.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/19/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import UIKit
import MapKit

class UpdateLocationViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton : UIButton!
    let userLocation : String = Constants.StudentInformation.location
    var lat : CLLocationDegrees = 0.0
    var long : CLLocationDegrees = 0.0
    let link : String = ""
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = userLocation
        
        let searchLocation = MKLocalSearch(request: searchRequest)
        searchLocation.start(completionHandler: {(response,error) in performUIUpdatesOnMain {
            if let error = error {
                self.finishButton.isEnabled = false
                self.displayAlert("Location not found", "Location not Found", "OK")
            }
           
            if let mapItems = response?.mapItems{
                if let mapLocation = mapItems.first{
                    self.annotation.coordinate = mapLocation.placemark.coordinate
                    self.lat = self.annotation.coordinate.latitude
                    self.long = self.annotation.coordinate.longitude
                    self.mapView.addAnnotation(self.annotation)
                    let region = MKCoordinateRegion(center: self.annotation.coordinate, span: MKCoordinateSpanMake(0.005, 0.005))
                    self.mapView.region = region
                    
                }
            }
            }})
            
    }
    
    
    @IBAction func pressFinishButton(_ sender: Any) {
        
        
    }
    
    
    func displayAlert(_ title : String, _ message : String , _ action : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
