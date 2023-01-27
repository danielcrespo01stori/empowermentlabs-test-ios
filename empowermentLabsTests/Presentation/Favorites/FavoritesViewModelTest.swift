//
//  FavoritesViewModelTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import XCTest
import Resolver
@testable import empowermentLabs

class FavoritesViewModelTest: XCTestCase {
    private var sut: FavoritesViewModel!
    
    override func setUp() {
        Resolver.registerMockServices()
        sut = FavoritesViewModel(realmManager: Resolver.resolve(RealmManagerType.self))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testOnDisAppear_WhenThereIsChangeState_ThenStateEmptyViewDataWasChanged() {
        // When
        sut.onDisAppear()
        // Then
        XCTAssertFalse(sut.loading)
    }
    
}
