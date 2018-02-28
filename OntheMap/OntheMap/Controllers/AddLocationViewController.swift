//
//  AddLocationViewController.swift
//  OntheMap
//
//  Created by Abhilash Khare on 2/18/18.
//  Copyright © 2018 Abhilash Khare. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var link: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
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
                self.present(controller!, animated: true, completion: nil)
                
        }
        
    }

    
    func displayAlert(_ title : String, _ message : String , _ action : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
