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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        getStudentLocations()
    }
    
    // Make each annotation for the pin
    func makeLocations(stu:[Student]) -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for student in stu {
            //Create the coordinate based on lat and long
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            // Set name and url
            let first = student.firstName!
            let last = student.lastName!
            let mediaURL = student.mediaURL
            
            // Create the annotaion
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // add annotation to the annotation array
            annotations.append(annotation)
        }
        
        return annotations
    }
    
    // Make pin
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIButton
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // handle when users click on annotation
    func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == annotationView.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            app.openURL(NSURL(string: annotationView.annotation.subtitle!)!)
        }
    }

    //IBAction
    //Log user out of the app
    @IBAction func logout(sender: UIBarButtonItem) {
        StudentClient.sharedInstance().logoutOfSession() { (result, error) in
            if error != nil {
              self.alert("Failed to logout")
            } else {
                if let ses = StudentClient.sharedInstance().sessionID {
                    dispatch_async(dispatch_get_main_queue(), {
                        var nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("login") as! UIViewController
                        self.presentViewController(nextVC, animated: true, completion: nil)
                    })
                }
            }
        }
    }
    
    // Helper function
    // Get all students locations
    func getStudentLocations() {
        StudentClient.sharedInstance().getStudentLocations(){ (result, error) in
            if let results = result {
                dispatch_async(dispatch_get_main_queue()) {
                    var annotations = self.makeLocations(result!)
                    self.mapView.addAnnotations(annotations)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.alert("Failed to get users locations")
                }
            }
        }
    }
    
    // Reset student results
    func reset() {
       getStudentLocations()
    }
    
    // Go the the add Student location view
    func addStudent() {
        var nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("addStudentLocationVC") as! UIViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    // Setup navigation
    func setupNav() {
        var addImage = UIImage(named: "pin")
        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: addImage, style: UIBarButtonItemStyle.Plain, target: self, action: "addStudent")
        var rightRefreshBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "reset")
        self.navigationItem.setRightBarButtonItems([rightRefreshBarButtonItem,rightAddBarButtonItem], animated: true)
    }
    
    // Alert view
    func alert(text:String) {
        let alertView = UIAlertView()
        alertView.message = text
        alertView.addButtonWithTitle("Ok")
        alertView.show()
    }
}
