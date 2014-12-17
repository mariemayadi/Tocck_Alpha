//
//  currentLocationViewController.swift
//  Tocck
//
//  Created by Mariem Ayadi on 12/17/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Social

class currentLocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var parseLat = PFObject(className:"latData")
    var parseLong = PFObject(className:"longData")
    
    //NOTE:
    //The CLLocationManagerDelegate protocol defines the methods used to receive location and heading updates from a CLLocationManager object.
    
    let locationManager = CLLocationManager()
    
    //Have Lat and Long be global.
    //Default is Ford Hall
    var latitude :CLLocationDegrees = 42.315904
    var longitude :CLLocationDegrees = -72.637915
    
    //A structure that defines the area spanned by a map region.
    let span:MKCoordinateSpan = MKCoordinateSpanMake(0.001, 0.001)
    var buildingAnnotation = MKPointAnnotation()
    
    //NOTE:
    //The CLLocationManager class is the central point for configuring the delivery of location- and heading-related events to your app. You use an instance of this class to establish the parameters that determine when location and heading events should be delivered and to start and stop the actual delivery of those events. You can also use a location manager object to retrieve the most recent location and heading data.


    @IBOutlet weak var mapView: MKMapView!
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        println("Entered the function")
        
        //NOTE:
        //The CLGeocoder class provides services for converting between a coordinate (specified as a latitude and longitude) and the user-friendly representation of that coordinate.
        longitude = manager.location.coordinate.longitude
        latitude = manager.location.coordinate.latitude
        
        //----------------------------------------------------
        // Saves current lat/long to Parse
        //----------------------------------------------------
        
        parseLat["currentLat"] = manager.location.coordinate.latitude
        saveLat()
        
        parseLong["currentLong"] = manager.location.coordinate.longitude
        saveLong()
        
        //----------------------------------------------------
        
        
        //Structure containing a geographical coordinate
        var buildingLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //A structure that defines which portion of the map to display. (center coordinate + span)
        var regionOfInterest:MKCoordinateRegion = MKCoordinateRegionMake(buildingLocation, span)
        
        self.mapView.setRegion(regionOfInterest, animated: true)
        
        println("Assignment happended")
        println(longitude)
        println(latitude)
        
        buildingAnnotation.coordinate = buildingLocation
        buildingAnnotation.title = "Building"
        buildingAnnotation.subtitle = "What about it"
        
        self.mapView.addAnnotation(buildingAnnotation)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // A Map kit needs to have certain values
        
        println("inside viewDidLoad: Default Lat/Long")
        println(longitude)
        println(latitude)
        
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        //new for iOS8. We may add a description as to why we would like to add a user's description
        self.locationManager.startUpdatingLocation()
        
        
        
        //Structure containing a geographical coordinate
        var buildingLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //A structure that defines which portion of the map to display. (center coordinate + span)
        var regionOfInterest:MKCoordinateRegion = MKCoordinateRegionMake(buildingLocation, span)
        
        self.mapView.setRegion(regionOfInterest, animated: true)
        //NOTE:
        //animated --> Specify YES if you want the map view to animate the transition to the new region or NO if you want the map to center on the specified region immediately.
        
        //The MKPointAnnotation class defines a concrete annotation object located at a specified point.
        buildingAnnotation.coordinate = buildingLocation
        buildingAnnotation.title = "Building"
        buildingAnnotation.subtitle = "What about it"
        
        self.mapView.addAnnotation(buildingAnnotation)
        
        
        // start updatug location once the application is loaded
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        //new for iOS8. We may add a description as to why we would like to add a user's description
        self.locationManager.startUpdatingLocation()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tellThem(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("I am using Tocck in a new location")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
            
        } else {
            
            var alert = UIAlertController(title: "Accounts", message: "Please log in to Facebook to share", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //----------------------------------------------------
    
    //Saving the Latitude
    func saveLat(){
        parseLat.saveInBackgroundWithBlock { (success, error) -> Void in
            if(success) {
                NSLog("all done")
            } else {
                // handle error
            }
        }
    }
    
    //Saving the Latitude
    func saveLong(){
        parseLong.saveInBackgroundWithBlock { (success, error) -> Void in
            if(success) {
                NSLog("all done")
            } else {
                // handle error
            }
        }
    }
    
    //----------------------------------------------------
    
//    //Chatting with contact 1
//    @IBAction func chatWithMatch1(sender: UIButton) {
//        let theChatRoom = self.storyboard?.instantiateViewControllerWithIdentifier("theChatRoom") as chatRoomViewController
//        self.navigationController?.pushViewController(theChatRoom, animated: true)
//        
//    }
    
    //Leads to the conversion center -late/long to miles table update-
    @IBAction func dataCenterPressed(sender: UIButton) {
        let convertLatLong = self.storyboard?.instantiateViewControllerWithIdentifier("convertLatLong") as convertLatLongViewController
        self.navigationController?.pushViewController(convertLatLong, animated: true)
    }

}
