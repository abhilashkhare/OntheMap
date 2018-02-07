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
             print(String(data: data!, encoding: .utf8)!)
            let parsedResult :  [String: AnyObject]
            do
            {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                let latdictionary = try parsedResult["latitude"] as? [Double]
                print(latdictionary)
            }
            catch{
                print("error")
            }
         
            
            
            
        }
        task.resume()
        
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    

    }

  
}
