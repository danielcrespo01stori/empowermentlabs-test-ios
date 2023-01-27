//
//  RecipeDetailObject.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

struct RecipeDetailObject:Identifiable {
    var id: String
    var title: String
    var readyInMinutes: String
    var instructions: String
    var image: String
    var extendedIngredients: [RecipeIngredientObject]
    
    init(id: String,
         title: String,
         readyInMinutes: String,
         instructions: String,
         image: String,
         extendedIngredients: [RecipeIngredientObject]) {
        self.id = id
        self.title = title
        self.readyInMinutes = readyInMinutes
        self.instructions = instructions
        self.image = image
        self.extendedIngredients = extendedIngredients
    }
}
