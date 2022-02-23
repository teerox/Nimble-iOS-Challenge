//
//  MyEnvironment.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/20/22.
//

import Foundation

public enum MyEnvironment {
    
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let rootURL = "ROOT_URL"
            static let clientID = "CLIENT_ID"
            static let clientSecret = "CLIENT_SECRET"
        }
    }
    
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let rootURL: URL = {
        guard let rootURLstring = MyEnvironment.infoDictionary["ROOT_URL"] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
    
    static let clientID: String = {
        guard let apiKey = MyEnvironment.infoDictionary["CLIENT_ID"] as? String else {
            fatalError("Client id not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let clientSecret: String = {
        guard let apiKey = MyEnvironment.infoDictionary["CLIENT_SECRET"] as? String else {
            fatalError("Client Secret not set in plist for this environment")
        }
        return apiKey
    }()
}
