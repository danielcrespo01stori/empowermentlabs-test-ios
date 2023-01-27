//
//  RecipesRepositoriesStub.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Combine
@testable import empowermentLabs

final class RecipesRepositoriesStub {
    static var error: Error?
    static var responseRecipes: [RecipeObject]!
    static var responseDetailRecipe: RecipeDetailObject!
}

extension RecipesRepositoriesStub: RecipesRepositoriesType {
    func getRecipes(by query: String) -> AnyPublisher<[RecipeObject], Error> {
        let data = RecipesRepositoriesStub.responseRecipes ?? []
        let publisher = CurrentValueSubject<[RecipeObject], Error>(data)
        
        if let error = RecipesRepositoriesStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func getDetailRecipe(by id: String) -> AnyPublisher<RecipeDetailObject, Error> {
        let data = RecipesRepositoriesStub.responseDetailRecipe ?? RecipeDetailObject(
            id: "",
            title: "",
            readyInMinutes: "",
            instructions: "",
            image: "",
            extendedIngredients: []
        )
        
        let publisher = CurrentValueSubject<RecipeDetailObject, Error>(data)
        
        if let error = RecipesRepositoriesStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
    
    
}

