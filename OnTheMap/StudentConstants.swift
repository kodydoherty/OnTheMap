//
//  StudentConstants.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/12/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

extension StudentClient {
//    // MARK: - Constants
    struct Constants {

        // MARK: API Key
        static let ApiKey : String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseAPPID : String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let FacebookAPID : String = "365362206864879"

        // MARK: URLs
        static let BaseURLSecure : String = "https://api.parse.com/1/classes/StudentLocation"
        static let AuthorizationURL : String = "https://www.udacity.com/api/"
    }
    
    // MARK: - Methods
    struct Methods {
        
        // MARK: Account
        static let Session = "session"
        static let UsersID = "users/{id}"
        
        // MARK: Parse
        static let AccountIDFavorite = "{id}"

    }
    // MARK: - HTTP Headers
    struct HTTPHeader {
        static let ParseAPPID = "X-Parse-Application-Id"
        static let ParseAPIKey = "X-Parse-REST-API-Key"
    }
    
    // MARK: - JSON Resonse Keys
    struct JSONResponseKeys {
        static let objectId = "objectId"
        static let uniqureKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let createdAt = "createdAt"
        static let updatedAt = "updatedAt"
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
    }
}