//
//  DetailRecipeView.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Resolver
import SwiftUI
import SkeletonUI

struct DetailRecipeView<ViewModelType>: View where ViewModelType: DetailRecipeViewModelType {
    var recipe: RecipeObject?
    
    @ObservedObject var viewModel: ViewModelType = Resolver.resolve()
    
    @ViewBuilder
    var recipeContentView: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(viewModel.state.recipeDetail?.title)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .skeleton(with: viewModel.state.isLoading)
                .shape(type: .rectangle)
                .appearance(type: .gradient())
                .animation(type: .pulse())
            ZStack {
                AsyncImage(url: URL.getUrl(from: viewModel.state.recipeDetail?.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    AnyView(ActivityIndicator())
                }
                .skeleton(with: viewModel.state.isLoading)
                .shape(type: .rectangle)
                .appearance(type: .gradient())
                .animation(type: .pulse())
                .foregroundColor(Color.gray)
                .cornerRadius(4)
                .frame(maxWidth: .infinity, minHeight: DetailRecipeState.Constants.heightImageVertically)
            }
            HStack(alignment: .center, spacing: 20) {
                DetailRecipeState.Constants.clock
                    .skeleton(with: viewModel.state.isLoading)
                    .shape(type: .rectangle)
                    .appearance(type: .gradient())
                    .animation(type: .pulse())
                Text(viewModel.state.recipeDetail?.readyInMinutes)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .skeleton(with: viewModel.state.isLoading)
                    .shape(type: .rectangle)
                    .appearance(type: .gradient())
                    .animation(type: .pulse())
            }
            
            if let recipeDetail = viewModel.state.recipeDetail {
                Button(action: {
                    viewModel.saveRecipe(recipe: recipeDetail)
                }) {
                    HStack {
                        DetailRecipeState.Constants.handImage
                        Text(DetailRecipeState.Constants.youLike)
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
            }
        }
    }
    
    @ViewBuilder
    var ingredientsContentView: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text(DetailRecipeState.Constants.instructions)
                .font(.title3)
                .foregroundColor(.black)
                .skeleton(with: viewModel.state.isLoading)
                .shape(type: .rectangle)
                .appearance(type: .gradient())
                .animation(type: .pulse())
            Text(viewModel.state.recipeDetail?.instructions)
                .font(.subheadline)
                .foregroundColor(.black)
                .skeleton(with: viewModel.state.isLoading)
                .shape(type: .rectangle)
                .appearance(type: .gradient())
                .animation(type: .pulse())
            Text(DetailRecipeState.Constants.ingredient)
                .font(.title3)
                .foregroundColor(.black)
                .skeleton(with: viewModel.state.isLoading)
                .shape(type: .rectangle)
                .appearance(type: .gradient())
                .animation(type: .pulse())
            SkeletonForEachWithIndex(with: viewModel.state.recipeIngredients, quantity: viewModel.state.numberSkeletonCell) { _, loading, ingredient in
                IngredientCellView(recipeIngredient: ingredient, loading: loading)
            }
        }
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                recipeContentView
                ingredientsContentView
            }.padding()
                .onAppear {
                    viewModel.onAppear(recipe: recipe)
                }
                .onDisappear {
                    viewModel.onDisAppear()
                }
            Spacer()
        }
        .navigationBarTitle(DetailRecipeState.Constants.title, displayMode: .inline)
        .alert(isPresented: $viewModel.state.alert) {
            Alert(
                title: Text(RecipesState.Constants.error),
                message: Text(RecipesState.Constants.error),
                dismissButton: .cancel(Text(RecipesState.Constants.ok)))
        }
    }
}
