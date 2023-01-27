//
//  FavoritesViewModel.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Combine
import Resolver
import Foundation

final class FavoritesViewModel: BaseViewModel {
    private var recipesFavorites: [RecipeObject]?
    @Published var state = FavoritesState()
    
    private let realmManager: RealmManagerType
    
    init(realmManager: RealmManagerType) {
        self.realmManager = realmManager
        super.init()
        errorHandler = self
    }
    
    private func getFavoriteRecipe() {
        if let localRealm = realmManager.localRealm {
            let recipeFavorites = localRealm.objects(RecipeObjectRealm.self)
            bindRecipes(with: recipeFavorites.map(RecipeObject.init))
        }
    }
    
    private func bindRecipes(with RecipesObject: [RecipeObject]) {
        recipesFavorites = RecipesObject
        state.recipesFavorites = RecipesObject
        state.isLoading = false
        objectWillChange.send()
    }
}

extension FavoritesViewModel: FavoritesViewModelType {
    func onAppear() {
        state.isLoading = true
        objectWillChange.send()
        getFavoriteRecipe()
    }
    
    func onDisAppear() {
        loading = false
    }
    
    func deleteRecipe(with id: String) {
        if let localRealm = realmManager.localRealm {
            do {
                let recipeObjectDelete = localRealm.objects(RecipeObjectRealm.self).filter(NSPredicate(format: "id == %@", id))
                guard !recipeObjectDelete.isEmpty else { return }
                try localRealm.write {
                    localRealm.delete(recipeObjectDelete)
                    getFavoriteRecipe()
                }
            } catch let error {
                showError(error: error)
            }
        }
    }
}

extension FavoritesViewModel: BaseView {
    func showError(error: Error) {
        state.alert = true
        objectWillChange.send()
    }
}
