//
//  FavoriteCellView.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import SkeletonUI
import SwiftUI

struct FavoriteCellView: View {
    var recipe: RecipeObject?
    var loading: Bool
    
    
    init(recipe: RecipeObject?,
         loading: Bool) {
        self.recipe = recipe
        self.loading = loading
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                AsyncImage(url: URL.getUrl(from: recipe?.image)) { image in
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
            Text(recipe?.title)
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
