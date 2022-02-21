//
//  LoginViewModelTest.swift
//  Nimble-iOS-ChallengeTests
//
//  Created by Anthony Odu on 2/21/22.
//

import XCTest
import Foundation
@testable import Nimble_iOS_Challenge

class LoginViewModelTest: XCTestCase {
    
    var apiClient: APIClient!
    var cacheData: CacheData!
    

    override func setUpWithError() throws {
        apiClient = APIClient()
        cacheData = CacheData()
    }

    override func tearDownWithError() throws {
        apiClient = nil
        cacheData = nil
    }

    func testLoginWithCorrectDetails() throws {
        let viewModel = LoginViewModel(apiClient:apiClient, cachedData:cacheData)
        let expectation = expectation(description: "Waiting for data")
        viewModel.loginInUser(email: "dev@nimblehq.co", password: "12345678") {
            XCTAssertEqual(viewModel.loginSuccessful, true)
            expectation.fulfill()
        } onFailure: { _ in
            XCTFail()
            expectation.fulfill()
        } loading: { _ in }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testLoginWithEmptyDetails() throws {
        let viewModel = LoginViewModel(apiClient:apiClient, cachedData:cacheData)
        let expectation = expectation(description: "Waiting for data")
        viewModel.loginInUser(email: "", password: "") {
            expectation.fulfill()
        } onFailure: { _ in
            XCTAssertEqual(viewModel.loginSuccessful, false)
            expectation.fulfill()
        } loading: { _ in }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testLoginWithWrongDetails() throws {
        let viewModel = LoginViewModel(apiClient:apiClient, cachedData:cacheData)
        let expectation = expectation(description: "Waiting for data")
        viewModel.loginInUser(email: "oduekene@gmail.com", password: "23489") {
            expectation.fulfill()
        } onFailure: { error in
            XCTAssertEqual(viewModel.loginSuccessful, false)
            expectation.fulfill()
        } loading: { _ in }
        wait(for: [expectation], timeout: 5)
    }
    
    func testIfDataIsCached() throws {
        let viewModel = LoginViewModel(apiClient:apiClient, cachedData:cacheData)
        let expectation = expectation(description: "Waiting for data")
        viewModel.loginInUser(email: "dev@nimblehq.co", password: "12345678") {
            let value = self.cacheData.getAttributes()
            XCTAssert(value != nil)
            expectation.fulfill()
        } onFailure: { error in
            XCTFail()
            expectation.fulfill()
        } loading: { _ in }
        wait(for: [expectation], timeout: 5)
    }
    
    func testIfDataIsNotCached() throws {
        let viewModel = LoginViewModel(apiClient:apiClient, cachedData:cacheData)
        let expectation = expectation(description: "Waiting for data")
        viewModel.loginInUser(email: "oduekene@gmail", password: "5678") {
            expectation.fulfill()
        } onFailure: { error in
            let value = self.cacheData.getAttributes()
            XCTAssert(value == nil)
            expectation.fulfill()
        } loading: { _ in }
        wait(for: [expectation], timeout: 5)
    }
}
