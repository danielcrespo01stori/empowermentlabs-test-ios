//
//  DetailRecipeState.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import SwiftUI

final class DetailRecipeState: ObservableObject {
    @Published var recipeDetail: RecipeDetailObject?
    @Published var recipeIngredients: [RecipeIngredientObject] = []
    @Published var isLoading: Bool = true
    @Published var numberSkeletonCell: Int = 4
    @Published var alert: Bool = false
    
    enum Constants {
        static let title = "Recipe"
        static let instructions = "Instructions :"
        static let ingredient = "Ingredients :"
        static let youLike = "you like ?"
        static let heightImageVertically: CGFloat = 100.0
        static let handImage:Image = Image(systemName: "hand.thumbsup")
        static let clock:Image = Image(systemName: "clock")
    }
}
