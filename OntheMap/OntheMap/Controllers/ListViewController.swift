
  //ListViewController.swift
  //OntheMap

  //Created by Abhilash Khare on 2/13/18.
  //Copyright © 2018 Abhilash Khare. All rights reserved.


import UIKit
import Foundation


class ListViewController:  UITableViewController {

   var studentInfo : [studentInformation] = []

   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        displayList()
        
    }
    
    func displayList()
    {
        
        ParseClient.sharedInstance().getStudentsInformation({(success, data, error) in
            
            performUIUpdatesOnMain {
            if(error != nil)
            {
                print ("Error loading student data")
            }
            else
            {
                let  studentsArray = data!["results"]  as? [[String : AnyObject]]
        
                for student in studentsArray!
                {
                    self.studentInfo.append(studentInformation(dictionary : student))
                }
                
                if self.studentInfo.count != 0
                {
                    self.tableView.reloadData()
                }
            }
         }
     })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return studentInfo.count    }

    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCellOTM") as! ListCellOTM
        let info = studentInfo[(indexPath as NSIndexPath).row]
        
        
        if let firstname = info.firstName,let  lastname = info.lastName{
            
            cell.name.text = "\(firstname)"+" "+"\(lastname)"
            cell.URL.text =  info.mediaURL
        }
        return cell
        
    }

}
