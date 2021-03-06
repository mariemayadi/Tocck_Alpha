//
//  convertLatLongViewController.swift
//  Tocck
//
//  Created by Mariem Ayadi on 12/17/14.
//  Copyright (c) 2014 Mariem Ayadi. All rights reserved.
//

import UIKit

class convertLatLongViewController: UIViewController {
    
//    var matchMiles = PFObject(className:"farCloseUsers")
    
    var queriedMatches: [String] = []
    
    var myLat = 42.315904
    var myLong = -72.637915
    
    var latUser1 = 37.785834
    var longUser1 = -122.406417
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //----------------------------------------------
        // Retrieving user's latest Latitude
        //----------------------------------------------
        
        var myLastLat = PFQuery(className:"latData")
        myLastLat.orderByDescending("createdAt")
        myLastLat.limit = 1
        
        myLastLat.findObjectsInBackgroundWithBlock {
            (distances: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("My Last Lat data queries retrieved \(distances.count) as user.")
                // Do something with the found objects
                for lastRequest in distances {
                    println("Getting my last Lat ID")
                    NSLog("%@", lastRequest.objectId)
                    print("Last lat:")
                    //println(lastRequest["currentLat"] as String)
                    self.myLat = lastRequest["currentLat"] as Double / 57.295779513
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        //----------------------------------------------
        
        //----------------------------------------------
        // Retrieving user's latest Longitude
        //----------------------------------------------
        
        var myLastLong = PFQuery(className:"longData")
        myLastLong.orderByDescending("createdAt")
        myLastLong.limit = 1
        
        myLastLong.findObjectsInBackgroundWithBlock {
            (distances: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("My Last Long data queries retrieved \(distances.count) as user.")
                // Do something with the found objects
                for lastRequest in distances {
                    println("Getting my last Long ID")
                    NSLog("%@", lastRequest.objectId)
                    print("Last long:")
                    //println(lastRequest["currentLat"] as String)
                    self.myLong = lastRequest["currentLong"] as Double / 57.295779513
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        //----------------------------------------------
        
        
        //----------------------------------------------
        
        var matchesQuery = PFQuery(className:"farClose2Users")
        //requestedQuery.orderByAscending("miles")
        //requestedQuery.whereKey("ageDigit", greaterThan:21)
        //requestedQuery.whereKey("milesDigit", lessThan:15)
        //requestedQuery.limit = 3; // limit to at most the specified num of results
        // Sorts the results in ascending order by the score field
        matchesQuery.findObjectsInBackgroundWithBlock {
            (users: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("matches Queries retrieved \(users.count) as user.")
                // Do something with the found objects
                for user in users {
                    NSLog("%@", user.objectId)
                    self.queriedMatches.append(user.objectId)
                }
                for (index, queriedUser) in enumerate(self.queriedMatches) {
                    println("User \(index + 1): \(queriedUser)")
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            for (index, queriedUser) in enumerate(self.queriedMatches) {
                println("INSIDE! User \(index + 1): \(queriedUser)")
            }
        }
        
            //--------------------------------------------------
        
        //--------------------------------------------------
        //      USER 1 - distance update
        //--------------------------------------------------
        
        var user1Query = PFQuery(className:"farClose2Users")
        //user1Query.getObjectInBackgroundWithId(self.queriedMatches[0]) {
        //user1Query.getObjectInBackgroundWithId("XScYmQMi5Y") {
        user1Query.getObjectInBackgroundWithId("tLk1GcywJb") {
            (person: PFObject!, error: NSError!) -> Void in
            if error == nil {
                NSLog("%@", person)
                self.latUser1 = person["matchLat"] as Double / 57.295779513
                self.longUser1 = person["matchLong"] as Double / 57.295779513
                
                //Doing the math!
                
                var diffLat = self.latUser1 - self.myLat
                var diffLong = self.longUser1 - self.myLong
                
                var a = pow(sin(diffLat / 2),2) + cos(self.myLat) * cos(self.latUser1) * pow(sin(diffLong / 2),2)
                
                var c = 2 * atan2(sqrt(a), sqrt(1-a))
                
                // distance in miles = R * c (where R = 3961.0 is the radius of the Earth)
                var d = 3961.0 * c

                //----------------------------------------------------
                // Saves distance in Miles to Parse
                //----------------------------------------------------
                var matchMiles = PFObject(className:"farClose2Users")
                
                matchMiles["distFromUser"] = d as Double
                matchMiles.saveInBackgroundWithBlock { (success, error) -> Void in
                    if(success) {
                        NSLog("Saved Distance to Parse")
                    } else {
                        // handle error
                    }
                }
                
               
                
            } else {
                NSLog("%@", error)
            }
        }
        
        //-------------------------------------------------------------------------
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    //Saving miles from User
//    func saveDistFromUser(){
//        matchMiles.saveInBackgroundWithBlock { (success, error) -> Void in
//            if(success) {
//                NSLog("Saved Distance to Parse")
//            } else {
//                // handle error
//            }
//        }
//    }


}

//    //-------------------------------------------------------------------------
//    //  Conversion from lat/long to miles (radius)
//    //-------------------------------------------------------------------------
//
//    //R = Radius of the earth = 3961 miles (equivalent to 6373 km)
//    let R = 3961.0
//
//    //1 radian = 57.295779513 degrees:
//
//    let lat1 = 38.898556 / 57.295779513
//    //GLKMathDegreesToRadians(lat1)
//    let long1 = -77.037852 / 57.295779513
//
//    let lat2 = 38.897147 / 57.295779513
//    let long2 = -77.043934 / 57.295779513
//
//    var diffLat = lat2 - lat1
//    var diffLon = long2 - long1
//
//    //a = (sin(dlat/2))^2 + cos(lat1) * cos(lat2) * (sin(dlon/2))^2
//    var a = pow(sin(diffLat / 2),2) + cos(lat1) * cos(lat2) * pow(sin(diffLon / 2),2)
//
//    //c = 2 * atan2( sqrt(a), sqrt(1-a) )
//    var c = 2 * atan2(sqrt(a), sqrt(1-a))
//
//    //d = R * c (where R is the radius of the Earth)
//    var d = R * c
//
//    //-------------------------------------------------------------------------