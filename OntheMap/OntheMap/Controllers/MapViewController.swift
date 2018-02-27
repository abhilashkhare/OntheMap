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
        callstudentInformation()
    }
    
   
    @IBAction func callstudentInformation()
    {
        ParseClient.sharedInstance().getStudentsInformation({(success, data, error) in
            
            if(error != nil)
            {
                print ("Error loading student data")
            }
                
            else
            {
                let  studentsArray = data!["results"]  as? [[String : AnyObject]]
                
                var studentInfo : [studentInformation] = []
                
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
        for student in studentinfo
        {
            if let latitude = student.latitude, let longitude = student.longitude {
                let lat = CLLocationDegrees(latitude)
                let long = CLLocationDegrees(longitude)
                
                let coordinate =   CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let firstName = student.firstName
                let lastName = student.lastName
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(String(describing: firstName))" + " " + "\(String(describing: lastName))"
                annotation.subtitle = student.mediaURL
                
                annotations.append(annotation)
    
            }
            
            }
        
        performUIUpdatesOnMain {
            self.map.addAnnotations(self.annotations)
        }
        
        
        }
    
    
    @IBAction func addLocation(_ sender: Any) {
        
        if(userInformation.objectID == nil){
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
            self.present(controller, animated: true, completion: nil)
        }
        
        else
        {
           displayAlert("User has already posted a student location. Would you like to OverWrite their location?")
        
    }
    }
    
    func displayAlert( _ message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Overwrite", style: .default, handler: { (action) in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
            self.present(controller, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    }
    


  

