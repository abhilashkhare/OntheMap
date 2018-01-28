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
    
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: .utf8)

        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {

                print(error!)
                self.errorTextArea.text = error as! String
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print("testing")
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}
