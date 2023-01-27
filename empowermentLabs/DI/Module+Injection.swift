//
//  Module+Injection.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import Resolver
import RealmSwift

extension Resolver {
    static func RegisterModuleDependencies (with baseUrl: String){
        registerData(with: baseUrl)
        registerDomain()
        registerPresentation()
    }
    
}

extension Resolver {
    static func registerData(with baseUrl: String) {
        register {
            URLSession(configuration: URLSession.configuration())
        }
        register {
            NetworkService(url: baseUrl, urlSession: resolve(URLSession.self))
        }.implements(NetworkServiceType.self)

        register {
            RecipesRepositories(networkService: resolve(NetworkServiceType.self))
        }.implements(RecipesRepositoriesType.self)
        
        register {
            RealmManager()
        }.implements(RealmManagerType.self)
        
    }
    
    static func registerDomain(){
   
        register {
            GetRecipesByQueryUseCase(repository: resolve(RecipesRepositoriesType.self))
        }.implements( AnyUseCase<String, [RecipeObject]>.self)
        
        register {
            GetDetailRecipeUseCase(repository: resolve(RecipesRepositoriesType.self))
        }.implements( AnyUseCase<String, RecipeDetailObject>.self)
    }
    
    static func registerPresentation() {
        
        register(RecipesViewModel.self){ _ in
            return RecipesViewModel(getRecipesByQueryUseCase: resolve(AnyUseCase<String, [RecipeObject]>.self))
        }
        
        register(DetailRecipeViewModel.self){ _ in
            let detailRecipeViewModel = DetailRecipeViewModel(
                getDetailRecipeUseCase: resolve(AnyUseCase<String, RecipeDetailObject>.self),
                realmManager: resolve(RealmManagerType.self))
            return detailRecipeViewModel
        }
        
        register(FavoritesViewModel.self) {_ in
            let favoritesViewModel = FavoritesViewModel(realmManager: resolve(RealmManagerType.self))
            return favoritesViewModel
        }
    }
    
}
