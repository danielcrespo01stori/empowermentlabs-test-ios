//
//  RecipesRepositoriesTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Foundation
import XCTest
import Combine

@testable import empowermentLabs

final class RecipesRepositoriesTest: XCTestCase {
    
    private var cancellable: AnyCancellable?
    private var networkService: NetworkServiceType!
    private var sut: RecipesRepositoriesType!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        sut = RecipesRepositories(networkService: networkService)
    }
    
    override func tearDown() {
        NetworkServiceMock.response = nil
        NetworkServiceMock.error = nil
        sut = nil
        cancellable = nil
        super.tearDown()
    }
    
    func testGetRecipesByQueryRepository_ResponseSuccess() {
        //Given
        let expectationFailure = expectation(description: "failure")
        let successExpectation = expectation(description: "Consume Web Service Response Expectation")
        expectationFailure.isInverted = true
        
        NetworkServiceMock.response = TestDataConstants.resultResponse as AnyObject
        
        //When
        self.cancellable = sut.getRecipes(by: "1")
            .sink { completion in
                guard case .failure(let error) = completion else {
                    return
                }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            } receiveValue: { response in
                // then
                XCTAssertNotNil(response)
                successExpectation.fulfill()
            }
        
        //Then
        self.wait(for: [expectationFailure, successExpectation], timeout: 1)
        self.cancellable?.cancel()
    }
    
    func testGetRecipesByQueryRepository_ResponseFailure() {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = expectation(description: "Consume Web Service Response Expectation")
        expectation.isInverted = true
        NetworkServiceMock.response = TestDataConstants.resultResponse as AnyObject
        NetworkServiceMock.error = NetworkError.emptyJson
        
        //When
        self.cancellable = sut.getRecipes(by: "1")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return
                    XCTFail("completion is not a failure")
                }
                XCTAssertEqual(error.localizedDescription, NetworkError.emptyJson.localizedDescription)
                expectationFailure.fulfill()
            },
            receiveValue: { _ in
                // Then
                expectation.fulfill()
            })
        
        //Then
        self.wait(for: [expectationFailure, expectation], timeout: 1)
        self.cancellable?.cancel()
    }
    
    func testGetDetailRecipeRepository_ResponseSuccess() {
        //Given
        let expectationFailure = expectation(description: "failure")
        let successExpectation = expectation(description: "Consume Web Service Response Expectation")
        expectationFailure.isInverted = true
        
        NetworkServiceMock.response = TestDataConstants.recipeDetailResponse as AnyObject
        
        //When
        self.cancellable = sut.getDetailRecipe(by: "782585")
            .sink { completion in
                guard case .failure(let error) = completion else {
                    return
                }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            } receiveValue: { response in
                // then
                XCTAssertNotNil(response)
                successExpectation.fulfill()
            }
        
        //Then
        self.wait(for: [expectationFailure, successExpectation], timeout: 1)
        self.cancellable?.cancel()
    }
    
    func testGetDetailRecipeRepository_ResponseFailure() {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume Web Service Response Expectation")
        expectation.isInverted = true
        
        NetworkServiceMock.response = TestDataConstants.recipeDetailResponse as AnyObject
        NetworkServiceMock.error = NetworkError.emptyJson
        
        //When
        self.cancellable = sut.getDetailRecipe(by: "782585")
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return
                    XCTFail("completion is not a failure")
                }
                XCTAssertEqual(error.localizedDescription, NetworkError.emptyJson.localizedDescription)
                expectationFailure.fulfill()
            },
            receiveValue: { _ in
                // Then
                expectation.fulfill()
            })
        
        //Then
        self.wait(for: [expectationFailure, expectation], timeout: 1)
        self.cancellable?.cancel()
    }
}
