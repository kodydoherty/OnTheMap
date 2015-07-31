//
//  StudentConvenience.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/13/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import Foundation


extension StudentClient {
    
    // Log user in with username and password
    func loginWithUsernameAndPassword(email:String, password:String, completionHandler: (sessionID: String, errorString: String?) -> Void) {
        var data:[String:AnyObject] = [
            "udacity": [
                "username" : email,
                "password" : password
            ]
        ]
        StudentClient.sharedInstance().userID = email
        let task = taskForPOSTMethod(Constants.AuthorizationURL,method: Methods.Session,jsonBody: data) { (JSONResult , error) in
            if let error = error {
                completionHandler(sessionID: "" , errorString: error.description)
            } else {
                if let result = JSONResult.valueForKey("session") as? [String:String] {
                    if let session = result["id"] {
                        self.sessionID = session
                        completionHandler(sessionID: "done", errorString: nil)
                    }
                } else {
                    completionHandler(sessionID: "", errorString: "Failed to parse session from JSON")
                }
            }
        }
    }
    
    //Get a Udacity Users information
    func getUdacityUsersInfo(completionHandler: (results: String, errorString: String? ) -> Void) {
        let task = taskForUdacityGETMethod( "users", completionHandler: {(result, error) in
            if let result = result.valueForKey("user") as? [String:AnyObject] {
                if let lastname = result["last_name"] as? String {
                    self.lastName = lastname
                    if let firstname = result["first_name"] as? String {
                        self.firstName = firstname
                        completionHandler(results: "done", errorString: nil)
                    } else {
                        completionHandler(results: "" , errorString: "Failed to parse firstname from JSON")
                    }
                } else {
                    completionHandler(results: "" , errorString: "Failed to parse lastname from JSON")
                }
            } else {
                completionHandler(results: "" , errorString: "Failed to parse user from JSON")
            }
        })
    }
    
    //Logout out user from the app
    func logoutOfSession(completionHandler: (result: String, errorString: String?) -> Void) {
        let task = taskForDeleteMethod(Constants.AuthorizationURL,method: Methods.Session) { (JSONResult , error) in
            if let error = error {
                completionHandler(result: "" , errorString: error.description)
            } else {
                if let result = JSONResult.valueForKey("session") as? [String:String] {
                    if let session = result["id"] {
                        self.sessionID = session
                        completionHandler(result: "done", errorString: nil)
                    }
                } else {
                    completionHandler(result: "", errorString: "Failed to parse session from JSON")
                }
            }
        }
    }
    
    // Get all the student locations
    func getStudentLocations(completionHandler: (results: [Student]?, errorString: String?) -> Void) {
        var students = [Student]()
        let task = taskForGETMethod(["limit":"100"], method: "") { (JSONResult, error) in
            if let error = error {
                completionHandler(results: students , errorString: error.description)
            } else {
                if let result = JSONResult.valueForKey("results") as? [[String:AnyObject]] {
                    students = Student.studentFromResults(result)
                    completionHandler(results: students , errorString: nil)
                } else {
                    completionHandler(results: students, errorString: "Failed to parse results from JSON")
                }
            }
        }
    }
    
    // Post new student location
    func postStudentLocations(data:[String:AnyObject], completionHandler: (result: String, errorString: String?) -> Void) {
        let task = taskForPOSTParseMethod(Constants.BaseURLSecure,method: "", jsonBody: data) { (JSONResult , error) in
            print(JSONResult)
            if let error = error {
                completionHandler(result: "" , errorString: error.description)
            } else {
                if let result = JSONResult.valueForKey("createdAt") as? String {
                        completionHandler(result: result, errorString: nil)
                } else {
                    completionHandler(result: "", errorString: "Failed to parse object from JSON")
                }
            }
        }
    }
}