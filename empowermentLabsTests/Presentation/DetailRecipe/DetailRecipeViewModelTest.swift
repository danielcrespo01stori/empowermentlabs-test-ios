//
//  DetailRecipeViewModelTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import XCTest
import Resolver
@testable import empowermentLabs

class DetailRecipeViewModelTest: XCTestCase {
    private var sut: DetailRecipeViewModel!
    
    override func setUp() {
        Resolver.registerMockServices()
        
        sut = DetailRecipeViewModel(
            getDetailRecipeUseCase: Resolver.resolve(AnyUseCase<String, RecipeDetailObject>.self),
            realmManager: Resolver.resolve(RealmManagerType.self)
        )
    }
    
    override func tearDown() {
        GetDetailRecipeUseCaseStub.error = nil
        sut = nil
        super.tearDown()
    }
    
    func testOnAppear_WhenReturnSucces_ThenChangeStateRecipeDetailWasChanged() {
        // Given
        let expectation = XCTestExpectation(description: "get detail Recipe")
        GetDetailRecipeUseCaseStub.recipeDetail = TestDomainConstants.recipeDetail
        
        // When
        sut.onAppear(recipe: TestDomainConstants.recipe)
        
        // Then
        let result = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(sut.state.recipeDetail?.id)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testOnAppear_WhenThereIsError_ThenChangeStateRecipeDetailWasChanged() {
        // Given
        let expectation = XCTestExpectation(description: "get detail Recipe")
        GetDetailRecipeUseCaseStub.error = NetworkError.serverError
        
        // When
        sut.onAppear(recipe: TestDomainConstants.recipe)
        
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
