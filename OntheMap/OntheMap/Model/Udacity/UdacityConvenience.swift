//
//  UdacityConvenience.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/20/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import Foundation
import UIKit

extension UdacityClient{
    
  public  func authentication(_ viewController : UIViewController, _ username : String, _ password : String,
                        completionHandlerforAuth : @escaping (_ success : Bool, _ result : AnyObject, _ error : String?) ->Void) {
        taskforPOSTmethod(username,password){
            (result,error) in performUIUpdatesOnMain {
            
                if error != nil{
                 
                    completionHandlerforAuth(false,result!,error!)
                    
                }
                else
                {
                    if  let account = result!["account"] as? [String : AnyObject],let key = account["key"] as? String{
                        uniqueKey = key
                        print(uniqueKey)

                completionHandlerforAuth(true,result!,nil)
                    }
                }
            }
        }
        
    }
    
}



