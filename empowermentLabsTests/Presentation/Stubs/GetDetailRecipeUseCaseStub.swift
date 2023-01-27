//
//  GetDetailRecipeUseCaseStub.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Combine
import Foundation
@testable import empowermentLabs

class GetDetailRecipeUseCaseStub: AnyUseCase<String, RecipeDetailObject> {
        
    static var recipeDetail = RecipeDetailObject(
        id: "",
        title: "",
        readyInMinutes: "",
        instructions: "",
        image: "",
        extendedIngredients: []
    )
    
    static var error: Error?
    
    override func execute(params: String) -> AnyPublisher<RecipeDetailObject, Error> {
        let publisher = CurrentValueSubject<RecipeDetailObject, Error>(GetDetailRecipeUseCaseStub.recipeDetail)
        if let error = GetDetailRecipeUseCaseStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
}

