//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/12/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var students = [Student]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        StudentClient.sharedInstance().getStudentLocations(){ (result, error) in
            if error != "" {
                println(error)
            } else {
                self.students = result
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func logout(sender: UIBarButtonItem) {
        StudentClient.sharedInstance().logoutOfSession() { (result, error) in
            if result != "" {
                if let ses = StudentClient.sharedInstance().sessionID {
                    dispatch_async(dispatch_get_main_queue(), {
                        var nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("login") as! UIViewController 
                        self.presentViewController(nextVC, animated: true, completion: nil)
                    })
                    
                }
            } else {
                println(error)
            }
            
        }
    }
}
