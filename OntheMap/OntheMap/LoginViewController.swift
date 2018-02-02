//
//  LoginViewController.swift
//  OntheMap
//
//  Created by Abhilash Khare on 1/27/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var username : UITextField!
    @IBOutlet var password : UITextField!
    
    @IBOutlet weak var errorTextArea: UITextView!
    
    @IBAction func loginPressed(_ sender : AnyObject)
    {
        errorTextArea.text = ""
        let usernameText = username.text!
        let passwordtext = password.text!
        
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: .utf8)

        request.httpBody = "{\"udacity\": {\"username\": \"\(usernameText)\", \"password\": \"\(passwordtext)\"}}".data(using: .utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {

                print(error!)
                self.errorTextArea.text = error as! String
                return
            }
            
            
            
            func sendError(_ error: String) {
                print(error)
                self.errorTextArea.text = "Please enter valid credentials"
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
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}
