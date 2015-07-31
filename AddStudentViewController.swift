//
//  AddStudentViewController.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/26/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit
import MapKit

class AddStudentViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findMapButton: UIButton!
    
    @IBOutlet weak var activityViewer: UIActivityIndicatorView!
    //Varibales for posting location
    var data = [String:AnyObject]()
    var lat:Double?
    var long:Double?
    var address: String?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the buttons rounded
        findMapButton.layer.cornerRadius = 10
        submitButton.layer.cornerRadius = 10
        activityViewer.hidesWhenStopped = true
        // Hide the map and URL view
        newViewHidden(true)
    }
    
    // IBAction
    // Cancel Adding a new location
    @IBAction func cancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // Get lat and long for the students location string and display map and url view
    @IBAction func FindOnMapButton(sender: UIButton) {
        self.activityViewer.startAnimating()
        self.address = locationTextField.text
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
           if let placemark = placemarks?[0] as? CLPlacemark {
                self.newViewHidden(false)
            
                // Change the color of the cancel button to white to match the new background
                self.cancelButton.titleLabel?.textColor = UIColor.whiteColor()
            
                // add Marker to confirm location
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
            
                // Set lat long cordiantes of the users location
                self.lat = placemark.location.coordinate.latitude
                self.long = placemark.location.coordinate.longitude
            
            
                self.activityViewer.stopAnimating()
                // Get the users first and last name to for the location post to parse
                StudentClient.sharedInstance().getUdacityUsersInfo(){ (result, errorString) in
                    if errorString != nil {
                        println(errorString)
                        dispatch_async(dispatch_get_main_queue()) {
                          self.alert("Issue getting user data")
                        }
                    } 
                }
           } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.alert("Invalid Address")
                    }
            }
        })
    }
    
    @IBAction func submit(sender: UIButton) {
        // Setup the data to post
        
        var data:[String:AnyObject?] = [
            "uniqueKey": StudentClient.sharedInstance().userID ,
            "firstName": StudentClient.sharedInstance().firstName,
            "lastName" : StudentClient.sharedInstance().lastName,
            "mapString": self.address,
            "mediaURL": self.formatURL(urlTextField.text),
            "latitude": self.lat,
            "longitude":self.long,
        ]
        //unwrap optional data to post
        let newdata:[String:AnyObject!] = (data as? [String:AnyObject])!
        
        // Post data to create a new student location
        StudentClient.sharedInstance().postStudentLocations(newdata, completionHandler: { (result, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.alert("Issue creating user location")
                }
            }
        })
        // Go back to previous view
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Helper functions
    func alert(text:String) {
        let alertView = UIAlertView()
        alertView.message = text
        alertView.addButtonWithTitle("Ok")
        alertView.show()
    }
    
    func newViewHidden(visable:Bool) {
        self.newView.hidden = visable
        self.mapView.hidden = visable
    }
    
    // Format url
    func formatURL(url:String) -> String {
        let prefix = url.substringToIndex(advance(url.startIndex, 7))
        if prefix == "http://" {
            return url
        } else {
            return "http://\(url)"
        }
    }
}
