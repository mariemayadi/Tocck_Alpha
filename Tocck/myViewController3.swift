//
//  myViewController3.swift
//  Tocck
//
//  Created by Mariem Ayadi on 12/1/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit

class myViewController3: UIViewController {

    @IBAction func numMiles(sender: UITextField) {
        miles["numMiles"] = sender.text
        saveMiles()
    }
    
    var miles = PFObject(className:"Miles")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
