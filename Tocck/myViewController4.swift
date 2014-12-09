//
//  myViewController4.swift
//  Tocck
//
//  Created by Mariem Ayadi on 12/1/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit

class myViewController4: UIViewController {

    var person = PFObject(className:"fiveSampleUsers")
    var person2 = PFObject(className:"oneTestUser")
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        var firstQuery = PFQuery(className:"fiveSampleUsers")
        firstQuery.getFirstObjectInBackgroundWithBlock {
            (object: PFObject!, error: NSError!) -> Void in
            if object != nil {
                self.person = object
                self.firstName1.text = self.person["firstName"] as String
                self.lastName1.text = self.person["lastName"] as String
                self.age1.text = self.person["age"] as String
                //self.profilePic1.image = self.person["picture"] as? UIImage
                //self.profilePic1.image =
            } else {
            }
        }
        
        var secondQuery = PFQuery(className:"fiveSampleUsers")
        secondQuery.getObjectInBackgroundWithId("9VwDICrSSy") {
            (object: PFObject!, error: NSError!) -> Void in
            if error == nil {
                NSLog("%@", object)
                self.person2 = object
                self.firstName2.text = self.person2["firstName"] as String
                self.lastName2.text = self.person2["lastName"] as String
                self.age2.text = self.person2["age"] as String
                //self.profilePic1.image = self.person["picture"] as? UIImage
                //self.profilePic1.image =
            } else {
                NSLog("%@", error)
            }
        }
        
        //WORKING with queries:
            // -- retrieve User with specified first name --
        var testQueryFN = PFQuery(className:"fiveSampleUsers")
        testQueryFN.whereKey("firstName", equalTo:"Brian")
        testQueryFN.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) as user.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        // -- retrieve User with specified age --
        var testQueryAGE = PFQuery(className:"fiveSampleUsers")
        testQueryAGE.whereKey("age", equalTo:"21")
        testQueryAGE.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) as user.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        // -- retrieve User with more specific requirments --
        
        var testQueries = PFQuery(className:"moreUsers")
        //[testQueries whereKey:"age" notEqualTo:"17"]
        testQueries.whereKey("age", notEqualTo:"20")
        testQueries.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("TestQueries retrieved \(objects.count) as user.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        var testNumQueries = PFQuery(className:"moreUsers")
        //[testQueries whereKey:"age" notEqualTo:"17"]
        testNumQueries.orderByAscending("miles")
        testNumQueries.whereKey("numAge", greaterThan:17)
        testNumQueries.whereKey("miles", lessThan:10)
        testNumQueries.limit = 10; // limit to at most the specified num of results
        // Sorts the results in ascending order by the score field
        testNumQueries.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("testNumQueries retrieved \(objects.count) as user.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
//        var queryNewInfo = PFQuery(className:"oneTestUser")
//        queryNewInfo.getFirstObjectInBackgroundWithBlock {
//            (object: PFObject!, error: NSError!) -> Void in
//            if object != nil {
//                self.person2 = object
//                self.firstName2.text = self.person2["firstName"] as String
//                self.lastName2.text = self.person2["lastName"] as String
//                self.age2.text = self.person2["age"] as String
//                //self.profilePic1.image = self.person["picture"] as? UIImage
//                //self.profilePic1.image =
//            } else {
//            }
//        }
        
        person.ACL = PFACL(user: PFUser.currentUser())
        
    }

    
    
//    let userImageFile = userPhoto["imageFile"] as PFFile
//    userImageFile.getDataInBackgroundWithBlock {
//    (imageData: NSData!, error: NSError!) -> Void in
//    if !error {
//    let image = UIImage(data:imageData)
//    }
//    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
