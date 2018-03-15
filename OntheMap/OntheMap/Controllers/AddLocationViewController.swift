//
//  AddLocationViewController.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/18/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var link: UITextField!
    
  
    @IBAction func cancel (_ sender : Any)
{
    self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func findLocation (_ sender : Any)
    {
        let url = URL(string : link.text!)
            
        if url?.scheme != "https"
            {
                displayAlert("","Please enter HTTPS://","OK")
            }
        else
            if(!(link.text?.contains("://"))!)
        {
            displayAlert("","Please enter HTTPS://","OK")
        }
        else
            {
            Constants.StudentInformation.location = location.text!
            Constants.StudentInformation.url = link.text!
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "UpdateLocationViewController")
                self.present(controller!, animated: true, completion: {() -> Void in
                  
                })
                
        }
        
    }

    
    func displayAlert(_ title : String, _ message : String , _ action : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location.delegate = self
        link.delegate = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddLocationViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddLocationViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        
        NotificationCenter.default.removeObserver(self,  name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self,  name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification : NSNotification)
    {
      
            
            let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
            self.view.frame.origin.y -= (keyboardSize?.cgRectValue.height)!/2

    }
    
    
    @objc func keyboardWillHide(notification : NSNotification)
    {
      
            self.view.frame.origin.y = 0
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
