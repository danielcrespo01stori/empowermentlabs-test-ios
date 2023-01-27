//
//  GetRecipesByQueryUseCase.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import Combine

class GetRecipesByQueryUseCase: AnyUseCase<String, [RecipeObject]> {
    let repository: RecipesRepositoriesType
    
    init(repository: RecipesRepositoriesType) {
        self.repository = repository
    }
    
    override func execute(params: String) -> AnyPublisher<[RecipeObject], Error> {
        return repository.getRecipes(by: params)
    }
}
