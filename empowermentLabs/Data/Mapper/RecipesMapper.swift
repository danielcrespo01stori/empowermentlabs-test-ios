//
//  RecipesMapper.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

public struct RecipesMapper: MapperType {
    typealias Input = APIResultResponse
    typealias Output = [RecipeObject]
    
    static func map(input: APIResultResponse) -> [RecipeObject] {
        let recipes = input.results.map {
            getRecipe(input: $0)
        }
        return recipes
    }
    
    private static func getRecipe(input: APIRecipeResponse) -> RecipeObject {
        return RecipeObject(
            id: String(input.id),
            title: input.title,
            image: input.image,
            imageType: input.imageType
        )
    }
}
