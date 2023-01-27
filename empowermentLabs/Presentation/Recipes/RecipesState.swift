//
//  RecipesState.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import SwiftUI

final class RecipesState: ObservableObject {
    @Published var recipes: [RecipeObject] = []
    @Published var isLoading: Bool = true
    @Published var numberSkeletonCell: Int = 4
    @Published var alert: Bool = false
    
    enum Constants {
        static let title = "Recipes"
        static let favoriteImage:Image = Image(systemName: "star.fill")
        static let error = "Error"
        static let ok = "Ok"
    }
}
