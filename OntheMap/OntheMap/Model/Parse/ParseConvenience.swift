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
{
    // GETting studentlocations
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
    
    //GETting a student location
    
    func getStudentInformation(_ completionHandlerForGetStudentInfo : @ escaping (_ success : Bool , _ result : AnyObject?, _ errorString : String?) -> Void )
    {
        let parameters = ["where" : "{\"uniqueKey\":\"\(Constants.StudentInformation.uniqueKey)\"}"]
        taskForGETMethod(parameters: parameters as [String : AnyObject]) { (result, error) in

            if let error = error {
                print(error)
                completionHandlerForGetStudentInfo(false,nil,"Failed to GET student information")

            }
            else
            {
                
                var userLocation : studentInformation
                var results = result!["results"]  as? [[String : AnyObject]]
                userLocation = studentInformation(dictionary: (results?.popLast())!)
                userInformation  = userLocation
                
                
                completionHandlerForGetStudentInfo(true , result , nil)
            }
    }
 }
    
    func putStudentInformation( _ completionHandlerForPut : @ escaping(_ success : Bool , _ error : Error?) -> Void)
    {
        
        
        let httpBody = "{\"uniqueKey\":\"\(Constants.StudentInformation.uniqueKey)\", \"firstName\": \"\(userInformation.firstName)\", \"lastName\": \"\(userInformation.lastName)\",\"mapString\": \"\(userInformation.mapString)\", \"mediaURL\": \"\(userInformation.mediaURL)\",\"latitude\": \"\(userInformation.latitude)\", \"longitude\": \"\(userInformation.longitude)\"}"
        print(httpBody)
        taskForPUTMethod(httpBody,userInformation.objectID!)
        {(success,error) in
            if let error = error
            {
                completionHandlerForPut(false,error)
            }
            else
            {
                completionHandlerForPut(true,nil)
            }
            
        }
    }
    
 
}

        


