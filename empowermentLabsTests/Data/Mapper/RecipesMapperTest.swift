//
//  RecipesMapperTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

@testable import empowermentLabs
import XCTest

class RecipesMapperTest: XCTestCase {
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testRecipesMapper_WhenInputIsFilled_ThenReturnObjectFilled() throws {
        // Given
        let input = TestDataConstants.resultResponse
        // when
        let result = RecipesMapper.map(input: input)
        // then
        XCTAssertEqual(result.count, input.results.count)
    }
}
