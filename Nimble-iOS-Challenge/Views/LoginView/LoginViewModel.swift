//
//  LoginViewModel.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation

class LoginViewModel {
    
    let apiClient: APIClient?
    let cachedData: CacheData?
    var loginSuccessful: Bool = false
    
    init(apiClient: APIClient, cachedData: CacheData) {
        self.apiClient = apiClient
        self.cachedData = cachedData
    }
    
    func loginInUser(email:String, password:String,onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void, loading: @escaping (Bool) -> Void) {
        
        email.isEmpty || password.isEmpty ? onFailure("Enter Email or Password") :
        loading(true)
        apiClient?.load(LoginResponse.self, Endpoint.signIn(email: email, password: password), completion: { [weak self] result in
            loading(false)
            guard let self = self else {
                return
            }
            switch result {
            case .failure(let info):
                self.cachedData?.saveAttributes(data: nil)
                switch info {
                case .invalidRequest(let value):
                    self.loginSuccessful = false
                    onFailure(value)
                }
            case .success(let data):
                self.cachedData?.saveAttributes(data: data.data.attributes)
                self.loginSuccessful = true
                onSuccess()
            }
        })
    }
}
