//
//  StudentConvenience.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/13/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import Foundation


extension StudentClient {
    
    func loginWithUsernameAndPassword(email:String, password:String, completionHandler: (sessionID: String, errorString: String?) -> Void) {
        var data:[String:AnyObject] = [
            "udacity": [
                "username" : email,
                "password" : password
            ]
        ]
       
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
    
    func logoutOfSession(completionHandler: (sessionID: String, errorString: String?) -> Void) {
        
        let task = taskForDeleteMethod(Constants.AuthorizationURL,method: Methods.Session) { (JSONResult , error) in
            
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
    
    func getStudentLocations(completionHandler: (results: [Student], errorString: String?) -> Void) {
        var students = [Student]()
        let task = taskForGETMethod(Constants.BaseURLSecure, method: "") { (JSONResult, error) in
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
}