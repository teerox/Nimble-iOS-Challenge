//
//  CacheData.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation

final class CacheData {
    
    let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults.standard
    }
    
    func saveAttributes(data: Attributes?) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            UserDefaults.standard.set(data, forKey: "attributes")
        } catch {
            debugPrint("Unable to decode meteors \(error)")
        }
    }
    
    func getAttributes() -> Attributes? {
        if let data = UserDefaults.standard.data(forKey: "attributes") {
            do {
                let decoder = JSONDecoder()
                
                let attributes = try decoder.decode(Attributes.self, from: data)
                
                return attributes
                
            } catch {
                debugPrint("Unable to decode meteors \(error)")
            }
        }
        return nil
    }
}
