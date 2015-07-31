//
//  Student.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/12/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

struct Student {
    var objectId: String?
    var uniqueKey : String?
    var firstName : String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Double = 0.0
    var longitude:Double = 0.0
    var createdAt: String?
    var updatedAt: String?
    
    // Parse dictionairy into Student Object properties
    init(dictionary:[String:AnyObject]) {
        objectId = dictionary[StudentClient.JSONResponseKeys.objectId] as? String
        uniqueKey = dictionary[StudentClient.JSONResponseKeys.uniqureKey] as? String
        firstName = dictionary[StudentClient.JSONResponseKeys.firstName] as? String
        lastName = dictionary[StudentClient.JSONResponseKeys.lastName] as? String
        mapString = dictionary[StudentClient.JSONResponseKeys.mapString] as? String
        mediaURL = dictionary[StudentClient.JSONResponseKeys.mediaURL] as? String
        latitude = (dictionary[StudentClient.JSONResponseKeys.latitude] as? Double)!
        longitude = (dictionary[StudentClient.JSONResponseKeys.longitude] as? Double)!
        createdAt = dictionary[StudentClient.JSONResponseKeys.createdAt] as? String
        updatedAt = dictionary[StudentClient.JSONResponseKeys.updatedAt] as? String
    }
    
    // Create an array of Students
    static func studentFromResults(results: [[String: AnyObject]]) -> [Student] {
        var students = [Student]()
        for result in results {
            var stu = Student(dictionary: result)
            if stu.firstName != "nil" {
               students.append(stu)
            }
        }
        return students
    }
}
