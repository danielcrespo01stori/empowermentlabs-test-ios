//
//  IngredientCellView.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 25/01/23.
//

import SkeletonUI
import SwiftUI

struct IngredientCellView: View {
    
    var recipeIngredient: RecipeIngredientObject?
    var loading: Bool
    
    init(recipeIngredient: RecipeIngredientObject?, loading: Bool) {
        self.recipeIngredient = recipeIngredient
        self.loading = loading
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                AsyncImage(url: URL.getUrl(from: recipeIngredient?.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    AnyView(ActivityIndicator())
                }
                .skeleton(with: loading)
                .shape(type: .rectangle)
                .appearance(type: .gradient())
                .animation(type: .pulse())
                .foregroundColor(Color.gray)
                .cornerRadius(4)
                .frame(width: 50, height: 50)
            }
            .foregroundColor(.gray)
            Text(recipeIngredient?.name)
                .font(.subheadline)
                .foregroundColor(.black)
                .skeleton(with: loading)
                .shape(type: .rectangle)
                .appearance(type: .gradient())
                .animation(type: .pulse())
            Spacer()
        }
    }
}
