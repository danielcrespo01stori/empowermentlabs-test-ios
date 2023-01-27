//
//  ApiRecipeDetailResponse.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

struct ApiRecipeDetailResponse: Codable {
    var id: Int
    var title: String
    var readyInMinutes: Int
    var instructions: String
    var image: String
    var extendedIngredients: [APIIngredientResponse]
    
    init(id: Int,
         title: String,
         readyInMinutes: Int,
         instructions: String,
         image: String,
         extendedIngredients: [APIIngredientResponse]) {
        self.id = id
        self.title = title
        self.readyInMinutes = readyInMinutes
        self.instructions = instructions
        self.image = image
        self.extendedIngredients = extendedIngredients
    }
}
