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
            
                if (error != nil) && (error == "Your request returned a status code other than 2xx!"){
                    completionHandlerforAuth(false,result!,error!)
                    
                }
                else
                {
                    if  let account = result!["account"] as? [String : AnyObject],let key = account["key"] as? String{
                         Constants.StudentInformation.uniqueKey = key

                        completionHandlerforAuth(true,result!,nil)
                    }
                }
            }
        }
    }
    
    public func logOutFunction (completionHandlerForLogOut : @escaping ( _ response : AnyObject, _ error : String?) -> Void)
    {
    
    var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "DELETE"
    var xsrfCookie: HTTPCookie? = nil
    let sharedCookieStorage = HTTPCookieStorage.shared
    for cookie in sharedCookieStorage.cookies! {
    if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
    }
    if let xsrfCookie = xsrfCookie {
        request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
       
        func sendError(_ error: String) {
            completionHandlerForLogOut("NULL" as AnyObject, error)
        }
        
        /* GUARD: Was there an error? */
        guard (error == nil) else {
            sendError("There was an error with your request: \(error!)")
            return
        }
        
        /* GUARD: Did we get a successful 2XX response? */
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            sendError("Your request returned a status code other than 2xx!")
            return
        }
        
        /* GUARD: Was there any data returned? */
        guard let data = data else {
            sendError("No data was returned by the request!")
            return
        }
        
        let range = Range(5..<data.count)
        let newData = data.subdata(in: range) /* subset response data! */
        print(String(data: newData, encoding: .utf8)!)
        completionHandlerForLogOut(newData as AnyObject,nil)
        
    }
    task.resume()
}

}

