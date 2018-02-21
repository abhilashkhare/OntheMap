//
//  StudentInformation.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/8/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import Foundation

struct studentInformation
{
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mediaURL: String?
    var objectID: String?
    var uniqueKey: String?
    var mapString: String?
    
    init(dictionary : [String : AnyObject])
    {
        firstName =  dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        mediaURL = dictionary["mediaURL"] as? String
        objectID = dictionary["objectId"] as? String
        uniqueKey = dictionary["uniqueKey"] as? String
        mapString = dictionary["mapString"] as? String
    }
}









