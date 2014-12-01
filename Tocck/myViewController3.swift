//
//  myViewController3.swift
//  Tocck
//
//  Created by Mariem Ayadi on 11/30/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit

class myViewController3: UIViewController {
    
    
    @IBAction func numMiles(sender: UITextField) {
    }
    
    var miles = PFObject(className:"Miles")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func slideValIN(sender: UISlider) {
        miles["numMiles"] = sender.value
        saveMiles()
    }
    
    //Saving the number of miles
    func saveMiles(){
        miles.saveInBackgroundWithBlock { (success, error) -> Void in
            if(success) {
                NSLog("all done")
            } else {
                // handle error
            }
        }
    }

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
