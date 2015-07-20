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
//
    }
    
    // MARK: - Methods
    struct Methods {
        
        // MARK: Account
        static let Session = "session"
        static let UsersID = "users/{id}"
        
        // MARK: Parse
        static let AccountIDFavorite = "{id}"
       
        
//        // MARK: Authentication
//        static let AuthenticationTokenNew = "authentication/token/new"
//        static let AuthenticationSessionNew = "authentication/session/new"
//        
//        // MARK: Search
//        static let SearchMovie = "search/movie"
//        
//        // MARK: Config
//        static let Config = "configuration"
        
    }
    
    // MARK: - URL Keys
//    struct URLKeys {
//        
//        static let UserID = "id"
//        
//    }
//    
    // MARK: - Parameter Keys
//    struct ParameterKeys {
    
//        static let ApiKey = "api_key"
//        static let SessionID = "session_id"
//        static let RequestToken = "request_token"
//        static let Query = "query"
        
//    }
    
    // MARK: - HTTP Headers
    struct HTTPHeader {
        static let ParseAPPID = "X-Parse-Application-Id"
        static let ParseAPIKey = "X-Parse-REST-API-Key"
    }
    
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
//        static let ACL : AnyObject?
        
    }
//
//    // MARK: - JSON Body Keys
//    struct JSONBodyKeys {
//        
//        static let MediaType = "media_type"
//        static let MediaID = "media_id"
//        static let Favorite = "favorite"
//        static let Watchlist = "watchlist"
//        
//    }
//
//    // MARK: - JSON Response Keys
//    struct JSONResponseKeys {
//        
//        // MARK: General
//        static let StatusMessage = "status_message"
//        static let StatusCode = "status_code"
//        
//        // MARK: Authorization
//        static let RequestToken = "request_token"
//        static let SessionID = "session_id"
//        
//        // MARK: Account
//        static let UserID = "id"
//        
//        // MARK: Config
//        static let ConfigBaseImageURL = "base_url"
//        static let ConfigSecureBaseImageURL = "secure_base_url"
//        static let ConfigImages = "images"
//        static let ConfigPosterSizes = "poster_sizes"
//        static let ConfigProfileSizes = "profile_sizes"
//        
//        // MARK: Movies
//        static let MovieID = "id"
//        static let MovieTitle = "title"
//        static let MoviePosterPath = "poster_path"
//        static let MovieReleaseDate = "release_date"
//        static let MovieReleaseYear = "release_year"
//        static let MovieResults = "results"
//        
//    }
    
}