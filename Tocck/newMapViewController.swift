//
//  newMapViewController.swift
//  Tocck
//
//  Created by Mariem Ayadi on 12/16/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit
import MapKit

class newMapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var userMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Have Lat and Long be global.
        //Default is Ford Hall
        var lat:CLLocationDegrees = 42.315904
        var long:CLLocationDegrees = -72.637915
        
        //A structure that defines the area spanned by a map region.
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.075, 0.075)
        
        //Structure containing a geographical coordinate
        var userLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        
        self.userMap.setRegion(theRegion, animated: true)
        
        var userLocationAnnotation = MKPointAnnotation()
        
        userLocationAnnotation.coordinate = userLocation
        userLocationAnnotation.title = "Hi"
        userLocationAnnotation.subtitle = "You're here!"
        
        self.userMap.addAnnotation(userLocationAnnotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Note: might be deleted since "back" takes care of that
    //Button sends us back to the match page
    @IBAction func toMatchesPressed(sender: UIButton) {

        let myMatches = self.storyboard?.instantiateViewControllerWithIdentifier("myMatches") as myViewController4
        self.navigationController?.pushViewController(myMatches, animated: true)
    }


}
