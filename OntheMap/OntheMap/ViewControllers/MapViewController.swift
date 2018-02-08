//
//  MapViewController.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/6/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet  var map : MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print("error")
                return
            }
       //      print(String(data: data!, encoding: .utf8)!)
            
            do
            {   let parsedResult :  [String: AnyObject]
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                var  studentsArray = parsedResult["results"]  as? [[String : AnyObject]]
              //  print(studentsArray)
                var latitude : [AnyObject] = []
                var longitude = [AnyObject]()
                print(studentsArray?.count)
                for i in 0...((studentsArray?.count)!-1)
                {
                    
                    latitude[i] = (studentsArray![i]["latitude"]  as? AnyObject)!
                    
                
                    longitude[i] = (studentsArray![i]["longitude"] as? AnyObject)!
                    
                }
                
                self.markPins(latitude,longitude)
            }
            catch{
                print("error")
            }
         
            
            
            
        }
        task.resume()
        
    
    }
    
    func markPins(_ latitude : [AnyObject], _ longtide : [AnyObject])
    {
        var location : [AnyObject] = []
        var coordinateRegion : [MKCoordinateRegion] = []
        for i in 0...(latitude.count-1)
        {
            location [i] = CLLocation(latitude: latitude[i] as! CLLocationDegrees, longitude: longtide[i] as! CLLocationDegrees)
            let regionRadius : CLLocationDistance = 1000
            coordinateRegion[i] = MKCoordinateRegionMakeWithDistance(location [i] as! CLLocationCoordinate2D , regionRadius, regionRadius)
            performUIUpdatesOnMain{
                self.map.setRegion(coordinateRegion[i], animated: true)
            }
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    

    }

  
}
