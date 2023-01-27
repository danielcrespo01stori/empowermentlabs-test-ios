//
//  DetailRecipeContract.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import SwiftUI

protocol DetailRecipeViewModelType: ObservableObject {
    var state: DetailRecipeState { get set }
    func onAppear(recipe: RecipeObject?)
    func saveRecipe(recipe: RecipeDetailObject)
    func onDisAppear()
}

