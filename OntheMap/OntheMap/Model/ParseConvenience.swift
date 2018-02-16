//
//  ParseConvenience.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/11/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import Foundation
import MapKit


extension ParseClient
{    //var annotations = [MKPointAnnotation]()

    
    func getStudentsInformation(_ completionHandlerForGetStudentsInfo : @ escaping (_ success : Bool, _ result : AnyObject?, _ errorString : String?) ->  Void)
    {
        /* 1. Set the parameters */
        let parameters = ["limit":100] as [String : AnyObject]
        
        /* 2/3. Build the URL, Configure the request */
        taskForGETMethod(parameters: parameters) { (result, error) in
            
            if let error = error {
                print(error)
               completionHandlerForGetStudentsInfo(false,nil,"Failed to GET student information")
                
            }
            else
            {
                completionHandlerForGetStudentsInfo(true , result , nil)
              
            }
             
        }
    }
}

        

