//
//  Constants.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/20/22.
//

import Foundation

class StoryboardNames {
    static let main = "Main"
}

class UrlConstants {
    static let baseURL = MyEnvironment.rootURL.absoluteString
    static let clientID = MyEnvironment.clientID
    static let clientSecret = MyEnvironment.clientSecret
    static let loginUrl = "/api/v1/oauth/token"
    static let refreshTokenUrl = "/api/v1/oauth/token"
    static let logOutUrl = "/api/v1/oauth/revoke"
    static let resetPasswordUrl = "/api/v1/passwords"
    static let getUserData = "/api/v1/me"
    static let getAllSurvey = "/api/v1/surveys"
    static let getSingleSurvey = "/api/v1/surveys/%@"
    
}
