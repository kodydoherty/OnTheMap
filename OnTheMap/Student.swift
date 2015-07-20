//
//  Student.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/12/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

struct Student {
    var objectId: String?
    var uniqureKey : String?
    var firstName : String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    
    var latitude: Float = 0.0
    var longitude:Float = 0.0
    var createdAt: String?
    var updatedAt: String?
//    var ACL : AnyObject?
    
    init(dictionary:[String:AnyObject]) {
        objectId = dictionary[StudentClient.JSONResponseKeys.objectId] as? String
        uniqureKey = dictionary[StudentClient.JSONResponseKeys.uniqureKey] as? String
        firstName = dictionary[StudentClient.JSONResponseKeys.firstName] as? String
        lastName = dictionary[StudentClient.JSONResponseKeys.lastName] as? String
        mapString = dictionary[StudentClient.JSONResponseKeys.mapString] as? String
        mediaURL = dictionary[StudentClient.JSONResponseKeys.mediaURL] as? String
        latitude = (dictionary[StudentClient.JSONResponseKeys.latitude] as? Float)!
        longitude = (dictionary[StudentClient.JSONResponseKeys.longitude] as? Float)!
        createdAt = dictionary[StudentClient.JSONResponseKeys.createdAt] as? String
        updatedAt = dictionary[StudentClient.JSONResponseKeys.updatedAt] as? String
    }
    
    static func studentFromResults(results: [[String: AnyObject]]) -> [Student] {
        var students = [Student]()
        
        for result in results {
            students.append(Student(dictionary: result))
        }
        return students
    }
}
