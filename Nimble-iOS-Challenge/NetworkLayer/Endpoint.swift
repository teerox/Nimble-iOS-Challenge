//
//  Endpoint.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/20/22.
//

import Foundation

struct Endpoint {
    let path: String
      let queryItems: [URLQueryItem]
      let requestType: RequestType
      let parameters: Parameters
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = UrlConstants.productionBaseUrl
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

// Authentication
extension Endpoint {

    static func signIn(email: String, password: String) -> Endpoint {
        return Endpoint(
            path: UrlConstants.productionBaseUrl,
            queryItems: [],
            requestType: .POST,
            parameters: ["grant_type":"password","email":email,"password":password,"client_id":UrlConstants.clientID,"client_secret":UrlConstants.clientSecret]
        )
    }
    
}
