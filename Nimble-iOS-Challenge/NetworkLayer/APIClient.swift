//
//  APIClient.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/20/22.
//

import Foundation
import SwiftyJSON

enum RequestType: String {
    case GET
    case POST
}

typealias Parameters = [String: Any]

enum HTTPError: Error {
    case invalidRequest(String)
}

final class APIClient {
    
    let cachedData: CacheData?
    
    init(cachedData: CacheData) {
        self.cachedData = cachedData
    }
    
    public func load<T: Codable>(_ model: T.Type, _ endpoint: Endpoint, completion: @escaping (Result<T, HTTPError>) -> Void) {
        
        
        
        
        guard let componentUrl = endpoint.url else {
            completion(.failure(.invalidRequest("Wrong URL")))
            return
        }
        
        var request = URLRequest(url: componentUrl, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = endpoint.requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = cachedData?.getAttributes() {
            var httpHeader: [String: String] {
                return ["Content-Type": "application/json",
                        "Accept": "application/json",
                        "Authorization": "Bearer " + token.accessToken]
            }
            request.allHTTPHeaderFields = httpHeader
        }
        if let param = endpoint.parameters {
            if let body = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) {
                request.httpBody = body
            }
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidRequest("Unable to connect")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let responseData = data else {
                completion(.failure(.invalidRequest("No data available")))
                return
            }
            if 200 ..< 300 ~= httpResponse.statusCode {
                do {
                    let responseJson = try JSONDecoder().decode(T.self, from: responseData)
                    let log = try JSON(data: responseData)
                   // print("responseCode : \(responseCode.statusCode)")
                    print("responseJSON : \(log)")
                    completion(.success(responseJson))
                }
                catch let parseJSONError {
                    completion(.failure(.invalidRequest("Invalid JSON")))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
                
            } else if httpResponse.statusCode == 400 {
                completion(.failure(.invalidRequest("unauthorized")))
                
                return
            }
            
            else if httpResponse.statusCode == 401 {
                if let atribute = self.cachedData?.getAttributes() {
                    if atribute.refreshToken.isEmpty {
                        completion(.failure(.invalidRequest("unauthorized")))
                        return
                    } else {
                        self.refreshToken(.refreshToken(token: self.cachedData?.getAttributes()?.refreshToken ?? "")) { [weak self] result in
                            guard let self = self else {
                                return
                            }
                            switch result {
                            case .failure(let info):
                                self.cachedData?.saveAttributes(data: nil)
                                switch info {
                                case .invalidRequest(let value):
                                    completion(.failure(.invalidRequest(value)))
                                }
                            case .success(let data):
                                self.cachedData?.saveAttributes(data: data.data.attributes)
                                self.load(model, endpoint, completion: completion)
                            }
                        }
                    }
                } else {
                    completion(.failure(.invalidRequest("Cannot connect to the server")))
                    return
                }
            }
            else if 400 ..< 500 ~= httpResponse.statusCode {
                completion(.failure(.invalidRequest("Cannot connect to the server")))
                
                return
            } else {
                completion(.failure(.invalidRequest("Cannot connect to the server")))
            }
            
        }.resume()
    }
    
    
    private func refreshToken(_ endpoint: Endpoint, completion: @escaping (Result<LoginResponse, HTTPError>) -> Void) {
        
        guard let componentUrl = endpoint.url else {
            completion(.failure(.invalidRequest("Wrong URL")))
            return
        }
        
        var request = URLRequest(url: componentUrl, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = endpoint.requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let param = endpoint.parameters {
            if let body = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) {
                request.httpBody = body
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidRequest("Unable to connect")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let responseData = data else {
                completion(.failure(.invalidRequest("No data available")))
                return
            }
            if 200 ..< 300 ~= httpResponse.statusCode {
                if let result = try? JSONDecoder().decode(LoginResponse.self, from: responseData) {
                    completion(.success(result))
                } else {
                    completion(.failure(.invalidRequest("Invalid JSON")))
                }
                
            } else if 400 ..< 500 ~= httpResponse.statusCode {
                completion(.failure(.invalidRequest("Cannot connect to the server")))
                
                return
            } else {
                completion(.failure(.invalidRequest("Cannot connect to the server")))
            }
        }.resume()
    }
}
