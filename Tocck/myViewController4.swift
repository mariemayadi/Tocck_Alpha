//
//  myViewController4.swift
//  Tocck
//
//  Created by Mariem Ayadi on 12/1/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit

class myViewController4: UIViewController {
    
    var queriedUsersID: [String] = ["3s8PPrUeU9"]
    //var queriedUsersID: [String] = []

    
    //First Match.
    @IBOutlet weak var firstName1: UITextField!
    @IBOutlet weak var lastName1: UITextField!
    @IBOutlet weak var age1: UITextField!
    @IBOutlet weak var profilePic1: UIImageView!
    
    //Second Match
    
    @IBOutlet weak var firstName2: UITextField!
    @IBOutlet weak var lastName2: UITextField!
    @IBOutlet weak var age2: UITextField!
    
    @IBOutlet weak var profilePic2: UIImageView!
    
    
    @IBOutlet weak var testPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //----------------------------------------------
        
        
        var requestedQuery = PFQuery(className:"fiveSampleUsers")
        requestedQuery.orderByAscending("miles")
        requestedQuery.whereKey("ageDigit", greaterThan:21)
        requestedQuery.whereKey("milesDigit", lessThan:15)
        requestedQuery.limit = 3; // limit to at most the specified num of results
        // Sorts the results in ascending order by the score field
        requestedQuery.findObjectsInBackgroundWithBlock {
            (users: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("requestedQueries retrieved \(users.count) as user.")
                // Do something with the found objects
                for user in users {
                    NSLog("%@", user.objectId)
                    self.queriedUsersID.append(user.objectId)
                    //NSLog("%@", self.queriedUsersID[0])
                }
                for (index, queriedUser) in enumerate(self.queriedUsersID) {
                    println("User \(index + 1): \(queriedUser)")
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            for (index, queriedUser) in enumerate(self.queriedUsersID) {
                println("INSIDE! User \(index + 1): \(queriedUser)")
            }
            
            //--------------------------------------------------
            //--------------------------------------------------
            
            var defaultQuery = PFQuery(className:"fiveSampleUsers")
            defaultQuery.getObjectInBackgroundWithId(self.queriedUsersID[0]) {
                (person: PFObject!, error: NSError!) -> Void in
                if error == nil {
                    NSLog("%@", person)
                    self.firstName1.text = person["firstName"] as String
                    self.lastName1.text = person["lastName"] as String
                    self.age1.text = person["age"] as String
                    
                    var imagePFFile = person["picture"] as PFFile
                    imagePFFile.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            self.profilePic1.image = UIImage(data:imageData)
                        }
                    }
                    
                } else {
                    NSLog("%@", error)
                }
            }
            
            //--------------------------------------------------
            //--------------------------------------------------
            
            var secondQuery = PFQuery(className:"fiveSampleUsers")
            secondQuery.getObjectInBackgroundWithId(self.queriedUsersID[1]) {
                (person: PFObject!, error: NSError!) -> Void in
                if person != nil {
                    self.firstName2.text = person["firstName"] as String
                    self.lastName2.text = person["lastName"] as String
                    self.age2.text = person["age"] as String
                    
                    var imagePFFile = person["picture"] as PFFile
                    imagePFFile.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            self.profilePic2.image = UIImage(data:imageData)
                        }
                    }
                    
                } else {
                }
            }
            
            //--------------------------------------------------
            //--------------------------------------------------
            
        }
        
        //--------------------------------------------
        for (index, queriedUser) in enumerate(self.queriedUsersID) {
            println("OUTSIDE! User \(index + 1): \(queriedUser)")
        }
        //--------------------------------------------


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
