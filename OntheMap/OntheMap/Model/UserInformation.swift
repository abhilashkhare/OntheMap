//
//  UserInformation.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/19/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import Foundation

var userInformation = studentInformation(dictionary: [:])

var exists : Bool = false

class SharedData {
    
    static let sharedInstance = SharedData()
    var StudentLocations = [studentInformation]()
    private init() {}
    
}
