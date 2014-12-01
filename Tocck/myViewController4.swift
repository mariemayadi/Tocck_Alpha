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
    var photo = PFObject(className:"fiveSampleUsers")
    
    @IBOutlet weak var firstName1: UITextField!
    
    @IBOutlet weak var lastName1: UITextField!
    
    @IBOutlet weak var age1: UITextField!
    
    @IBOutlet weak var profilePic1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        var queryTextInfo = PFQuery(className:"fiveSampleUsers")
        var queryImage = photo["picture"] as PFFile
        queryTextInfo.getFirstObjectInBackgroundWithBlock {
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
        queryImage.getDataInBackgroundWithBlock {
            (photo: NSData!, error: NSError!) -> Void in
            if !(error != nil) {
                self.profilePic1.image = self.photo["picture"] as? UIImage
            } else {
            }
        }
        
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
