//
//  newMapViewController.swift
//  Tocck
//
//  Created by Mariem Ayadi on 12/16/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit

class newMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toMatchesPressed(sender: UIButton) {
        
        ////let myMatches = self.storyboard?.instantiateViewControllerWithIdentifier("myMatches") as myViewController4
        
        ////self.navigationController?.popToViewController(myMatches, animated: true)
        
        //self.navigationController?.popToRootViewControllerAnimated(true)
        
//        let myMap = self.storyboard?.instantiateViewControllerWithIdentifier("myMap") as newMapViewController
//        self.navigationController?.pushViewController(myMap, animated: true)
        let myMatches = self.storyboard?.instantiateViewControllerWithIdentifier("myMatches") as myViewController4
        self.navigationController?.pushViewController(myMatches, animated: true)
    }


}
