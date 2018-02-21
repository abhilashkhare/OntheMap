//
//  UdacityClient.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/20/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import Foundation
import UIKit

class UdacityClient{
    

    func taskforPOSTmethod(_ username : String, _ password : String,completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: String?) -> Void) -> URLSessionDataTask{
        
        /* 2/3. Build the URL, Configure the request */
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        
        let session = URLSession.shared

        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                completionHandlerForPOST("NULL" as AnyObject, error)
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
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(newData, completionHandlerforConvertData: completionHandlerForPOST)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task

        }
    
    func convertDataWithCompletionHandler(_ data : Data, completionHandlerforConvertData : (_ result : AnyObject?, _ error : String?) -> Void )
    {
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            completionHandlerforConvertData( nil, "Could not parse the data as JSON: '\(data)'")
        }
        
        completionHandlerforConvertData(parsedResult, nil)
        
    }
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }


    
}
