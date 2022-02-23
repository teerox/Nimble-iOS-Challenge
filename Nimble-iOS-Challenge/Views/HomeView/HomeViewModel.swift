//
//  HomeViewModel.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation

class HomeViewModel {
    
    let apiClient: APIClient?
    let cachedData: CacheData?
    
    var userData: UserDataClass?
    var allSurvey: [HomeDatum] = []
    var singleSurvey: [SingleSurveyIncluded] = []
    
    init(apiClient: APIClient, cachedData: CacheData = CacheData()) {
        self.apiClient = apiClient
        self.cachedData = cachedData
    }
    
    func getUserData(onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void, loading: @escaping (Bool) -> Void) {
        loading(true)
        apiClient?.load(UserDataResponse.self, .getUserData(), completion: { [weak self] result in
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
                self.userData = data.data
                onSuccess()
            }
        })
    }
    
    func getAllSurvey(onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void, loading: @escaping (Bool) -> Void) {
        loading(true)
        apiClient?.load(HomeResponse.self, .getAllSurvey(), completion: { [weak self] result in
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
                self.allSurvey = data.data ?? []
                onSuccess()
            }
        })
    }
    
    
    func getUserSurvey(id: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void, loading: @escaping (Bool) -> Void) {
        loading(true)
        apiClient?.load(SingleSurveyResponse.self, .getSingleSurvey(id: id), completion: { [weak self] result in
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
                self.singleSurvey = data.included ?? []
                onSuccess()
            }
        })
    }
}


extension HomeViewModel {
    
    func filterSurveyList() -> [HomeDatum] {
        return allSurvey.filter {$0.type == .survey}
    }
    
    func getQuestionType() -> [String? : SingleSurveyIncluded]  {
        let questions = singleSurvey.filter{$0.type == .question}
        return Dictionary(uniqueKeysWithValues: questions.map{($0.id, $0) })
    }
    
    func getEachScreenData() -> EachScreenData? {
        var result : EachScreenData? = nil
        for (key,value) in getQuestionType() {
            result =  EachScreenData(id: key, text: value.attributes?.text, answers: value.relationships?.answers?.data, type: value.attributes?.displayType, pick: value.attributes?.pick, imageUrl: value.attributes?.imageURL, coverImageURL: value.attributes?.coverImageURL, coverImageOpacity: value.attributes?.coverImageOpacity)
            break
        }
        return result
    }
}


