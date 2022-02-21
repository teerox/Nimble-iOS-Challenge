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
    
    init(apiClient: APIClient, cachedData: CacheData) {
        self.apiClient = apiClient
        self.cachedData = cachedData
    }
    
    func loginInUser(email:String, password:String,onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void, loading: @escaping (Bool) -> Void) {
        loading(true)
        apiClient?.load(LoginResponse.self, .signIn(email: email, password: password), completion: { [weak self] result in
            loading(false)
            guard let self = self else {
                return
            }
            switch result {
            case .failure(let info):
                switch info {
                case .invalidRequest(let value):
                    onFailure(value)
                }
            case .success(let data):
                self.cachedData?.saveAttributes(data: data.data.attributes)
                onSuccess()
            }
        })
    }
}
