//
//  GCDBlackBox.swift
//  OntheMap
//
//  Created by Abhilash Khare on 1/29/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import Foundation

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
