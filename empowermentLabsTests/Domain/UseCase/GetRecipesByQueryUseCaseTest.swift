//
//  GetRecipesByQueryUseCaseTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Combine
import Resolver
@testable import empowermentLabs
import XCTest

class GetRecipesByQueryUseCaseTest: XCTestCase {
    private var sut: GetRecipesByQueryUseCase!
    @LazyInjected var recipesRepositories: RecipesRepositoriesType
    private var cancellable: AnyCancellable?
    private let query = ""
    
    override func setUpWithError() throws {
        Resolver.registerMockServices()
        sut = .init(repository: Resolver.resolve(RecipesRepositoriesType.self))
    }
    
    override func tearDownWithError() throws {
        sut = nil
        cancellable = nil
        RecipesRepositoriesStub.error = nil
        RecipesRepositoriesStub.responseRecipes = nil
        RecipesRepositoriesStub.responseDetailRecipe = nil
    }
    
    func testGetRecipesByQueryUseCase_ResponseSuccess() {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume Web Service Response Expectation")
        expectationFailure.isInverted = true
        
        RecipesRepositoriesStub.responseRecipes = TestDomainConstants.recipes
        
        //When
        cancellable = sut.execute(params: query)
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                XCTFail(error.localizedDescription)
                expectationFailure.fulfill()
            } receiveValue: { response in
                // Then
                XCTAssertFalse(response.isEmpty)
                expectation.fulfill()
            }
        
        wait(for: [expectationFailure, expectation], timeout: 1)
        cancellable?.cancel()
    }
    
    func testGetRecipesByQueryUseCase_ResponseError() {
        //Given
        let expectationFailure = expectation(description: "failure")
        let expectation = self.expectation(description: "Consume Web Service Response Expectation")
        expectation.isInverted = true
        
        RecipesRepositoriesStub.error = NetworkError.emptyJson
        
        //When
        cancellable = sut.execute(params: query)
            .sink(
                receiveCompletion: { completion in
                    guard case .failure(let error) = completion else { return
                        XCTFail("completion is not a failure")
                    }
                    // Then
                    let jsonEmptyError = NetworkError.emptyJson.localizedDescription
                    XCTAssertEqual(error.localizedDescription, jsonEmptyError)
                    expectationFailure.fulfill()
                },
                receiveValue: { _ in
                    expectation.fulfill()
                })
        
        wait(for: [expectationFailure, expectation], timeout: 1)
        cancellable?.cancel()
    }
}
