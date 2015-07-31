//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/12/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController  {
    
    // IBOutlets
    @IBOutlet var tb: UITableView!
    
    // Initilize variables
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the nav buttons
        setupNav()
       
        // Get all the student locations to fill the table
        getStudentLocations()
    }
    
    // Tableview functions
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentClient.sharedInstance().students.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tb.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var student = StudentClient.sharedInstance().students[indexPath.row]
        cell.textLabel!.text = "\(student.firstName!) \(student.lastName!)"
        cell.imageView?.image = UIImage(named: "mapblue")
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let app = UIApplication.sharedApplication()
        app.openURL(NSURL(string: StudentClient.sharedInstance().students[indexPath.row].mediaURL!)!)
    }
    
    // IBActions
    // Log user out of the app
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
                    
                } else {
                    self.alert("Network issues")
                }
            }
            
        }

    }
    // Helper functions
    func getStudentLocations() {
        StudentClient.sharedInstance().getStudentLocations(){ (result, error) in
            if let students = result {
                StudentClient.sharedInstance().students = students
                dispatch_async(dispatch_get_main_queue()) {
                    self.tb.reloadData()
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.alert("Could not load student data")
                }
            }
        }
    }
    // Helper Functions
    
    // Reset and update the results
    func reset() {
        getStudentLocations()
    }
    
    // Open the addStudent View
    func addStudent() {
        var nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("addStudentLocationVC") as! UIViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    // Setup the navigation
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
