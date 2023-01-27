//
//  DetailRecipeMapper.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

public struct DetailRecipeMapper: MapperType {
    
    typealias Input = ApiRecipeDetailResponse
    typealias Output = RecipeDetailObject
    
    
    static func map(input: ApiRecipeDetailResponse) -> RecipeDetailObject {
        let extendedIngredients = input.extendedIngredients.map {
            getIngredient(input: $0)
        }
        
        return RecipeDetailObject(
            id: String(input.id),
            title: input.title,
            readyInMinutes: "Ready in \(input.readyInMinutes) minutes",
            instructions: input.instructions.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil),
            image: input.image,
            extendedIngredients: extendedIngredients
        )
    }
    
    private static func getIngredient(input: APIIngredientResponse) -> RecipeIngredientObject {
        return RecipeIngredientObject(
            id: input.id,
            name: input.name,
            original: input.original,
            image: "\(DataConstants.resource.smallImage)\(input.image)")
    }
}
