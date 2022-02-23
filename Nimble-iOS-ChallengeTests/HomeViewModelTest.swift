//
//  HomeViewModelTest.swift
//  Nimble-iOS-ChallengeTests
//
//  Created by Anthony Odu on 2/22/22.
//

import XCTest
import Foundation
@testable import Nimble_iOS_Challenge

class HomeViewModelTest: XCTestCase {
    
    var apiClient: APIClient!
    var cacheData: CacheData!
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        cacheData = CacheData()
        apiClient = APIClient(cachedData: cacheData)
        viewModel = HomeViewModel(apiClient: apiClient, cachedData: cacheData)
    }

    override func tearDownWithError() throws {
        apiClient = nil
        cacheData = nil
        viewModel = nil
    }
    
    func testUserDetailIsAvailable() throws {
        let expectation = expectation(description: "Waiting for data")
        
        viewModel.getUserData {
            XCTAssert(self.viewModel.userData != nil)
            expectation.fulfill()
        } onFailure: { _ in
            XCTFail()
            expectation.fulfill()
        } loading: { _ in }
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchedHomeDataIsntEmpty() {
        let expectation = expectation(description: "Waiting for data")
        viewModel.getAllSurvey {
            XCTAssert(!self.viewModel.allSurvey.isEmpty)
            expectation.fulfill()
        }onFailure: { _ in
            XCTFail()
            expectation.fulfill()
        } loading: { _ in }
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testSingleSurveyHomeDataIsEmptyWithEmptyID() {
        let expectation = expectation(description: "Waiting for data")
        viewModel.getUserSurvey(id: "d5de6a8f8f5f1cfe51bc") {
            XCTAssert(!self.viewModel.singleSurvey.isEmpty)
            expectation.fulfill()
        }onFailure: { _ in
            XCTFail()
            expectation.fulfill()
        } loading: { _ in }
        wait(for: [expectation], timeout: 5)
    }
    
    func testSingleSurveyHomeDataIsEmptyWithWrondId() {
        let expectation = expectation(description: "Waiting for data")
        viewModel.getUserSurvey(id: "12345") {
        }onFailure: { _ in
            XCTAssert(self.viewModel.singleSurvey.isEmpty)
            expectation.fulfill()
        } loading: { _ in }
        wait(for: [expectation], timeout: 5)
    }
}
