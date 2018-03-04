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
        
        UdacityClient.sharedInstance().authentication(self, usernameText, passwordtext) { (success, data, error) in
            if(success == false)
            {
           
                performUIUpdatesOnMain{
                    self.errorTextArea.text = "Please enter valid username/password"
                }
            }
            else
            {
            performUIUpdatesOnMain{
                                let controller = self.storyboard!.instantiateViewController(withIdentifier: "OntheMapTabViewController") as! UITabBarController
                                self.present(controller, animated: true, completion: nil)
                ParseClient.sharedInstance().getStudentInformation({ (success, result, error) in
                    
                    if(success == false){
                        print("Issue retrieving userinformation")
                        
                    }
                    
                })
                    }
                
            }
            
            }
        
    
   

    }
    override func viewDidLoad() {
        super.viewDidLoad()
}
}
    





