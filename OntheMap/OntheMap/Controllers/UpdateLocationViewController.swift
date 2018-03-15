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
  let activityIndicator = UIActivityIndicatorView()
    
    let userLocation : String = Constants.StudentInformation.location
    var lat : CLLocationDegrees = 0.0
    var long : CLLocationDegrees = 0.0
    let link : String = ""
    let annotation = MKPointAnnotation()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = userLocation
        displayActivityIndicator()
        
        //ActivityIndicator starts just before geocoding starts
        activityIndicator.startAnimating()
        
        let searchLocation = MKLocalSearch(request: searchRequest)
        searchLocation.start(completionHandler: {(response,error) in performUIUpdatesOnMain {
           

            if let error = error {
                self.activityIndicator.stopAnimating()
                self.finishButton.isEnabled = false
                self.displayAlert("Location not found", "Location not Found", "OK")
            }
           
            if let mapItems = response?.mapItems{
                if let mapLocation = mapItems.first{
                    self.annotation.coordinate = mapLocation.placemark.coordinate
                    self.lat = self.annotation.coordinate.latitude
                    self.long = self.annotation.coordinate.longitude
                    self.annotation.title = mapLocation.name
                    self.mapView.addAnnotation(self.annotation)
                    let region = MKCoordinateRegion(center: self.annotation.coordinate, span: MKCoordinateSpanMake(0.005, 0.005))
                    self.mapView.region = region
                    userInformation.mediaURL = Constants.StudentInformation.url
                    userInformation.latitude = self.annotation.coordinate.latitude
                    userInformation.longitude = self.annotation.coordinate.longitude
                    userInformation.mapString = mapLocation.name
                   
                }
                //Stopping activityIndicator after geocoding is complete
                self.activityIndicator.stopAnimating()
            }
            }})
            
    }
    
    @IBAction func cancel (_ sender : Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func pressFinishButton(_ sender: Any) {
        activityIndicator.startAnimating()
        if(userInformation.objectID == nil){
            performUIUpdatesOnMain {
                
                ParseClient.sharedInstance().postStudentInformation()
                    {
                        (success,result,error) in
                        self.activityIndicator.stopAnimating()
                        if(error !=  nil)
                        {
                            print("Error posting location")
                            self.displayAlert("Error", "Error POSTING request", "Dismiss")
                        }
                        else
                        {
                            userInformation.objectID = result?["objectId"] as! String
                            print(userInformation.objectID)
                            debugPrint("Posted successfully")
                            
                       self.navigationController?.popToRootViewController(animated: true)
                            
                        }
                }
                
            }
            
        }
            
        else
        {
            performUIUpdatesOnMain {
            
                

          ParseClient.sharedInstance().putStudentInformation()
            {
                (success,error) in
                if(error !=  nil)
                {
                    print("Error posting location")
                    self.displayAlert("Error", "Error Postig request", "Dismiss")
                }
                else
                {
                    print("Posted(PUT) successfully")
//                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "OntheMapTabViewController")
//                    self.present(controller!, animated: true, completion: nil)
                  
                    performUIUpdatesOnMain {
                    //    self.addLocation.dismiss(animated: true, completion: nil)
                        print(self.navigationController?.popToRootViewController)
                        self.navigationController?.popToRootViewController(animated: true)


                    }

                }
            }

        }
        
        }
        
        
    }
    
    
    func displayAlert(_ title : String, _ message : String , _ action : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: {action in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayActivityIndicator()
    {
       
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        

    }


}
