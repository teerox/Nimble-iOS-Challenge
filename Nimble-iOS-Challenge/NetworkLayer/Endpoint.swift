//
//  Endpoint.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/20/22.
//

import Foundation

struct Endpoint {
    let path: String
      let queryItems: [URLQueryItem]?
      let requestType: RequestType
      let parameters: Parameters?
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = UrlConstants.baseURL
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

// Authentication
extension Endpoint {

    static func signIn(email: String, password: String) -> Endpoint {
        let value = Endpoint(
            path: UrlConstants.loginUrl,
            queryItems: nil,
            requestType: .POST,
            parameters: ["grant_type":"password","email":email,"password":password,"client_id":UrlConstants.clientID,"client_secret":UrlConstants.clientSecret]
        )
        return value
    }

    static func refreshToken(token: String) -> Endpoint {
        let value = Endpoint(
            path: UrlConstants.refreshTokenUrl,
            queryItems: nil,
            requestType: .POST,
            parameters: ["grant_type":"refresh_token","refresh_token":token,"client_id":UrlConstants.clientID,"client_secret":UrlConstants.clientSecret]
        )
        return value
    }
    
    static func signOut(token: String) -> Endpoint {
        let value = Endpoint(
            path: UrlConstants.logOutUrl,
            queryItems: nil,
            requestType: .POST,
            parameters: ["token":token,"client_id":UrlConstants.clientID,"client_secret":UrlConstants.clientSecret]
        )
        return value
    }
    
    static func resetPassword(email: String) -> Endpoint {
        let value = Endpoint(
            path: UrlConstants.resetPasswordUrl,
            queryItems: nil,
            requestType: .POST,
            parameters: ["user":["email":email],"client_id":UrlConstants.clientID,"client_secret":UrlConstants.clientSecret]
        )
        return value
    }
}


// Home
extension Endpoint {
    
    static func getUserData() -> Endpoint {
        let value = Endpoint(
            path: UrlConstants.getUserData,
            queryItems: nil,
            requestType: .GET,
            parameters: nil
        )
        return value
    }
    
    static func getAllSurvey() -> Endpoint {
        let value = Endpoint(
            path: UrlConstants.getAllSurvey,
            queryItems: nil,
            requestType: .GET,
            parameters: nil
        )
        return value
    }
    
    static func getSingleSurvey(id: String) -> Endpoint {
        let value = Endpoint(
            path:  String(format: UrlConstants.getSingleSurvey, id),
            queryItems: nil,
            requestType: .GET,
            parameters: nil
        )
        return value
    }
}
