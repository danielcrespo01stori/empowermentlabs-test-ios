//
//  RecipesViewModel.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Combine
import Resolver
import Foundation

final class RecipesViewModel: BaseViewModel {
    
    private var recipes: [RecipeObject]?
    private var subscribers: Set<AnyCancellable> = []
    @Published var state = RecipesState()
    private let getRecipesByQueryUseCase: AnyUseCase< String, [RecipeObject]>
    
    init(getRecipesByQueryUseCase: AnyUseCase< String, [RecipeObject]>) {
        self.getRecipesByQueryUseCase = getRecipesByQueryUseCase
        super.init()
        errorHandler = self
    }
    
    private func getRecipes(query: String) {
        getRecipesByQueryUseCase.execute(params: query)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.showError(error: error)
            } receiveValue: { [weak self] recipes in
                self?.bindRecipes(with: recipes)
            }
            .store(in: &subscribers)

    }
    
    private func bindRecipes(with RecipesObject: [RecipeObject]) {
        recipes = RecipesObject
        state.recipes = RecipesObject
        state.isLoading = false
        objectWillChange.send()
    }
    
}

extension RecipesViewModel: RecipesViewModelType {
    func onAppear(query: String) {
        state.isLoading = true
        objectWillChange.send()
        getRecipes(query: query)
    }
    
    func onDisAppear() {
        loading = false
    }
    
}

extension RecipesViewModel: BaseView {
    func showError(error: Error) {
        state.alert = true
        objectWillChange.send()
    }
}
