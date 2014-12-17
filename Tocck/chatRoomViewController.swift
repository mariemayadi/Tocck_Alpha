//
//  chatRoomViewController.swift
//  Tocck
//
//  Created by Mariem Ayadi on 12/16/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit

class chatRoomViewController: UIViewController, UIPickerViewDelegate {

    var purpose = ["New in Town","Week-end trip","Longer road trip","Just hang out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return purpose.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return purpose[row]
    }

}
