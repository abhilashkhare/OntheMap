
  //ListViewController.swift
  //OntheMap

  //Created by Abhilash Khare on 2/13/18.
  //Copyright © 2018 Abhilash Khare. All rights reserved.


import UIKit
import Foundation


class ListViewController:  UIViewController, UITableViewDelegate , UITableViewDataSource {

 //  var studentInfo : [studentInformation] = []

    @IBOutlet var tableView : UITableView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        displayList()
    
    }
    
  
    func displayList()
    {
        
        ParseClient.sharedInstance().getStudentsInformation({(success, data, error) in
            
            performUIUpdatesOnMain {
            if(error != nil)
            {
                print ("Error loading student data")
                self.displayAlert("Error", error!, "Cancel")
            }
            else
            {
                let  studentsArray = data!["results"]  as? [[String : AnyObject]]
        
                for student in studentsArray!
                {
//                    self.studentInfo.append(studentInformation(dictionary : student))
                    SharedData.sharedInstance.StudentLocations.append(studentInformation(dictionary : student))
                }
                
                if SharedData.sharedInstance.StudentLocations.count != 0
                {
                    print("count")
                    print(SharedData.sharedInstance.StudentLocations.count)
                    performUIUpdatesOnMain {
                        
                        self.tableView?.reloadData()
                    }
                    
                }
            }
         }
     })
    }
    
    @IBAction func refresh(_ sender : Any)
    {
        displayList()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        
        if(userInformation.objectID == nil){
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
            self.present(controller, animated: true, completion: nil)
        }
            
        else
        {
            displayAlertPop("User has already posted a student location. Would you like to OverWrite their location?")
            
        }
    }
    
    @IBAction  func logOut(_ sender : Any)
    {
        performUIUpdatesOnMain {
            
            
            UdacityClient.sharedInstance().logOutFunction { (data, error) in
                if error != nil
                {
                    let alert = UIAlertController(title:"Log off Error", message: "Could not log out", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Log off Error", style: .default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                        
                    }))
                }
                else{
                    print("Log off successful")
                    performUIUpdatesOnMain {
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            }
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return SharedData.sharedInstance.StudentLocations.count    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCellOTM") as! ListCellOTM
        let info = SharedData.sharedInstance.StudentLocations[(indexPath as NSIndexPath).row]
        
        tableView.rowHeight = 70
        
        if let firstname = info.firstName,let  lastname = info.lastName
        {
            cell.name.text = "\(firstname)"+" "+"\(lastname)"
            cell.URL.text =  info.mediaURL
        
        }
        return cell

    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let info = SharedData.sharedInstance.StudentLocations[(indexPath as NSIndexPath).row ]
        let url = URL( string : info.mediaURL!)
        
        if url?.scheme != "https"
        {
            displayAlert("","Invalid URL","Dismiss")
        }
        else
        {
            UIApplication.shared.open(url!)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func displayAlertPop( _ message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Overwrite", style: .default, handler: { (action) in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
            self.navigationController?.pushViewController(controller, animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    
    func displayAlert(_ title : String, _ message : String , _ action : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: {action in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    

}
