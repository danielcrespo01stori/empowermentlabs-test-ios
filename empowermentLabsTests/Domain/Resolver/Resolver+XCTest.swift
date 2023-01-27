//
//  Resolver+XCTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Foundation
import Resolver
import RealmSwift
@testable import empowermentLabs

extension Resolver  {
    static var mock = Resolver(child: .main)
    
    static func registerMockServices() {
        root = Resolver.mock
        defaultScope = .application
        
        register(FavoritesViewModel.self) {_ in
            let favoritesViewModel = FavoritesViewModel(realmManager: resolve(RealmManagerType.self))
            return favoritesViewModel
        }
        
        mock.register(RealmManagerType.self) {
            let realmManager = RealmManager()
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = #function
            let realm = try! Realm()
            realmManager.localRealm = realm
            return realmManager
        }
        
        mock.register { RecipesRepositoriesStub() }
            .implements(RecipesRepositoriesType.self)
        
        mock.register {
            GetRecipesByQueryUseCaseStub()
        }.implements(AnyUseCase<String, [RecipeObject]>.self)
        
        mock.register {
            GetDetailRecipeUseCaseStub()
        }.implements(AnyUseCase<String, RecipeDetailObject>.self)
        
        
    }
}
