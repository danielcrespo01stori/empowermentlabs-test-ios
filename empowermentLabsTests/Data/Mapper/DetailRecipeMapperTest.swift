//
//  DetailRecipeMapperTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

@testable import empowermentLabs
import XCTest

class DetailRecipeMapperTest: XCTestCase {
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testRecipesMapper_WhenInputIsFilled_ThenReturnObjectFilled() throws {
        // Given
        let input = TestDataConstants.recipeDetailResponse
        // when
        let result = DetailRecipeMapper.map(input: input)
        // then
        XCTAssertEqual(result.extendedIngredients.count, input.extendedIngredients.count)
    }
}
