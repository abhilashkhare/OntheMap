//
//  LoginViewController.swift
//  OntheMap
//
//  Created by Abhilash Khare on 1/27/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UINavigationControllerDelegate ,UITextFieldDelegate {

    @IBOutlet var username : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet weak var errorTextArea: UITextView!
    
    @IBAction func signUpPressed( _ sender : Any)
    {
        let url = URL(string : "https://auth.udacity.com/sign-up")
        UIApplication.shared.open(url!)
    }
    
    @IBAction func loginPressed(_ sender : AnyObject)
    {
        errorTextArea.text = ""
        let usernameText = username.text!
        let passwordtext = password.text!
        
        UdacityClient.sharedInstance().authentication(self, usernameText, passwordtext) { (success, data, error) in
            if(success == false)
            {
           if error == "Your request returned a status code other than 2xx!"
           {
            performUIUpdatesOnMain{
                self.errorTextArea.text = "Please enter valid email/password"
            }
                }
                else
            {
                performUIUpdatesOnMain{
                    self.errorTextArea.text = error
                    }
                }
            }
            else
            {
            performUIUpdatesOnMain{
                                let controller = self.storyboard!.instantiateViewController(withIdentifier: "OntheMapTabViewController") as! UITabBarController
                                self.present(controller, animated: true, completion: nil)
                    }
                }
                
            }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.delegate = self
        username.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        
        NotificationCenter.default.removeObserver(self,  name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self,  name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification : NSNotification)
    {
        if(password.isFirstResponder)
        {
            
            let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
            self.view.frame.origin.y -= (keyboardSize?.cgRectValue.height)!
            
        }
    }
    
    
    @objc func keyboardWillHide(notification : NSNotification)
    {
        if(password.isFirstResponder==true)
        {
            self.view.frame.origin.y = 0
            
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 

    

}

    





