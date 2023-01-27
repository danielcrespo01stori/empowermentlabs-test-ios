//
//  RecipesRepositoriesType.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Combine
import Foundation

protocol RecipesRepositoriesType {
    func getRecipes(by query: String) -> AnyPublisher<[RecipeObject], Error>
    func getDetailRecipe(by id: String) -> AnyPublisher<RecipeDetailObject, Error>
}
