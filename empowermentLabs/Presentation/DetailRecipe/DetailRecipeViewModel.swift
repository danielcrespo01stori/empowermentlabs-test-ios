//
//  DetailRecipeViewModel.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Combine
import Resolver
import Foundation

final class DetailRecipeViewModel: BaseViewModel {
    private var recipeDetail: RecipeDetailObject?
    private var subscribers: Set<AnyCancellable> = []
    @Published var state = DetailRecipeState()
    
    private let getDetailRecipeUseCase: AnyUseCase<String, RecipeDetailObject>
    private let realmManager: RealmManagerType
    init(getDetailRecipeUseCase: AnyUseCase<String, RecipeDetailObject>,
         realmManager: RealmManagerType) {
        self.getDetailRecipeUseCase = getDetailRecipeUseCase
        self.realmManager = realmManager
        super.init()
        errorHandler = self
    }
    
    private func getRecipe(_ recipe: RecipeObject) {
        getDetailRecipeUseCase.execute(params: recipe.id)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.showError(error: error)
            } receiveValue: { [weak self] recipeDetail in
                self?.bindRecipe(with: recipeDetail)
            }
            .store(in: &subscribers)
    }
    
    private func bindRecipe(with recipeDetailObject: RecipeDetailObject) {
        recipeDetail = recipeDetailObject
        state.recipeDetail = recipeDetailObject
        state.recipeIngredients = recipeDetailObject.extendedIngredients
        state.isLoading = false
        objectWillChange.send()
    }
}

extension DetailRecipeViewModel: DetailRecipeViewModelType {
    func saveRecipe(recipe: RecipeDetailObject) {
        if let localRealm = realmManager.localRealm {
            do {
                if let recipeObject = localRealm.object(ofType: RecipeObjectRealm.self, forPrimaryKey: recipe.id) {
                    try localRealm.write {
                        recipeObject.title = recipe.title
                        recipeObject.image = recipe.image
                    }
                }
                else {
                    try localRealm.write {
                        let recipeObject = RecipeObjectRealm(value: [
                            "id": recipe.id,
                            "title": recipe.title,
                            "image": recipe.image
                        ])
                        localRealm.add(recipeObject)
                    }
                }
            } catch let error {
                showError(error: error)
            }
        }
    }
    
    func onAppear(recipe: RecipeObject?) {
        state.isLoading = true
        objectWillChange.send()
        if let recipe = recipe {
            getRecipe(recipe)
        }
    }
    
    func onDisAppear() {
        loading = false
    }
}

extension DetailRecipeViewModel: BaseView {
    func showError(error: Error) {
        state.alert = true
        objectWillChange.send()
    }
}
