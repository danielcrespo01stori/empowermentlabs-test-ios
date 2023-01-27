//
//  FavoritesState.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import SwiftUI

final class FavoritesState: ObservableObject {
    @Published var recipesFavorites: [RecipeObject] = []
    @Published var isLoading: Bool = true
    @Published var numberSkeletonCell: Int = 4
    @Published var alert: Bool = false
    
    enum Constants {
        static let title = "Recipes favorites"
        static let delete = "Delete"
        static let trash = "trash"
    }
}
