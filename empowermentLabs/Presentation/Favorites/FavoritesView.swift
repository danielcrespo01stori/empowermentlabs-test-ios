//
//  FavoritesView.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Resolver
import SwiftUI
import SkeletonUI

struct FavoritesView<ViewModelType>: View where ViewModelType: FavoritesViewModelType {
    @ObservedObject var viewModel: ViewModelType = Resolver.resolve()
    
    var body: some View {
        List {
            ForEach(viewModel.state.recipesFavorites) { recipe in
                NavigationLink {
                    DetailRecipeView<DetailRecipeViewModel>(recipe: recipe)
                } label: {
                    FavoriteCellView(recipe: recipe, loading: false)
                        .swipeActions(edge: .leading) {
                            Button(role: .destructive) {
                                viewModel.deleteRecipe(with: recipe.id)
                            } label : {
                                Label(FavoritesState.Constants.delete,
                                      systemImage: FavoritesState.Constants.trash)
                            }
                        }
                }
            }
        }.listStyle(.inset)
        
            .onAppear {
                viewModel.onAppear()
            }
            .onDisappear {
                viewModel.onDisAppear()
            }
            .alert(isPresented: $viewModel.state.alert) {
                Alert(
                    title: Text(RecipesState.Constants.error),
                    message: Text(RecipesState.Constants.error),
                    dismissButton: .cancel(Text(RecipesState.Constants.ok)))
            }
            .navigationBarTitle(FavoritesState.Constants.title, displayMode: .inline)
        
    }
    
}
