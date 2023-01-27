//
//  RecipesView.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Resolver
import SwiftUI
import SkeletonUI

struct RecipesView<ViewModelType>: View where ViewModelType: RecipesViewModelType {
    
    @ObservedObject var viewModel: ViewModelType = Resolver.resolve()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            SkeletonList(with: viewModel.state.recipes,quantity: viewModel.state.numberSkeletonCell) { loading, recipe in
                NavigationLink {
                    DetailRecipeView<DetailRecipeViewModel>(recipe: recipe)
                } label: {
                    RecipeCellView(recipe: recipe, loading: loading)
                }
            }
            .listStyle(.inset)
            .navigationBarTitle(RecipesState.Constants.title, displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    NavigationLink {
                        FavoritesView<FavoritesViewModel>()
                    } label: {
                        RecipesState.Constants.favoriteImage
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .onChange(of: searchText) { index in
            viewModel.onAppear(query: index)
        }
        .onAppear {
            viewModel.onAppear(query: searchText)
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
    }
}
