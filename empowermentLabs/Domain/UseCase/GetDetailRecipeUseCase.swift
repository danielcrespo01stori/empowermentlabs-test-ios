//
//  GetDetailRecipeUseCase.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import Combine

class GetDetailRecipeUseCase: AnyUseCase<String, RecipeDetailObject> {
    let repository: RecipesRepositoriesType
    
    init(repository: RecipesRepositoriesType) {
        self.repository = repository
    }
    
    override func execute(params: String) -> AnyPublisher<RecipeDetailObject, Error> {
        return repository.getDetailRecipe(by: params)
    }
}
