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
    var annotations = [MKPointAnnotation]()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        ParseClient.sharedInstance().getStudentsInformation({(success, data, error) in
        
            if(error != nil)
            {
                print ("Error loading student data")
            }
     
            else
            {
             
              //  parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                let  studentsArray = data!["results"]  as? [[String : AnyObject]]
              //  print(studentsArray)
                
                var studentInfo : [studentInformation] = []

                print(studentsArray?.count)
                for student in studentsArray!
                {
                    
                    studentInfo.append(studentInformation(dictionary : student))
                }
                
                if studentsArray?.count != 0
                {
                    self.markPins(studentInfo)
                }
            }
        })
    }
    func markPins(_ studentinfo : [studentInformation])
    {
        //var location : [AnyObject] = []
   
   
      
        for student in studentinfo
        {
            if let latitude = student.latitude, let longitude = student.longitude {
                let lat = CLLocationDegrees(latitude)
                let long = CLLocationDegrees(longitude)
                
                let coordinate =   CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let firstName = student.firstName
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(firstName)"
                annotation.subtitle = student.mediaURL
                
                annotations.append(annotation)
    
            }
        
            
            }
        
        performUIUpdatesOnMain {
            self.map.addAnnotations(self.annotations)
        }
        
        
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    }
    


  

