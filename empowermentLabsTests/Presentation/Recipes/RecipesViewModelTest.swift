//
//  RecipesViewModelTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import XCTest
import Resolver
@testable import empowermentLabs

class RecipesViewModelTest: XCTestCase {
    private var sut: RecipesViewModel!
    
    override func setUp() {
        Resolver.registerMockServices()
        sut = RecipesViewModel(getRecipesByQueryUseCase: Resolver.resolve(AnyUseCase<String, [RecipeObject]>.self))
    }
    
    override func tearDown() {
        GetRecipesByQueryUseCaseStub.error = nil
        sut = nil
        super.tearDown()
    }
    
    func testOnAppear_WhenReturnSucces_ThenChangeStateRecipesWasChanged() {
        // Given
        let expectation = XCTestExpectation(description: "get Recipes")
        GetRecipesByQueryUseCaseStub.recipes = TestDomainConstants.recipes
        
        // When
        sut.onAppear(query: "")
        
        // Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.state.recipes.isEmpty)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testOnAppear_WhenThereIsError_ThenChangeStateRecipesWasChanged() {
        // Given
        let expectation = XCTestExpectation(description: "get Recipes")
        GetRecipesByQueryUseCaseStub.error = NetworkError.serverError
        
        // When
        sut.onAppear(query: "")
        
        // Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.state.alert)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testOnDisAppear_WhenThereIsChangeState_ThenStateEmptyViewDataWasChanged() {
        // When
        sut.onDisAppear()

        // Then
        XCTAssertFalse(sut.loading)
    }
}
