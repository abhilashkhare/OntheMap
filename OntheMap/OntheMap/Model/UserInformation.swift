//
//  UserInformation.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/19/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import Foundation

var userInformation = studentInformation(dictionary: [:])


class sharedData {
    
    static let sharedInstance = sharedData()
    var studentLocations = [studentInformation]()
    private init() {}
    
}
