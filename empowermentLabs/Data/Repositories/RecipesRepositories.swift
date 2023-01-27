//
//  RecipesRepositories.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Combine
import Foundation

class RecipesRepositories: RecipesRepositoriesType {
    
    private(set) var networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func getRecipes(by query: String) -> AnyPublisher<[RecipeObject], Error> {
        let endPoint = NetworkRequest<APIResultResponse>(
            method: .GET,
            relativePath:DataConstants.WS.getRecipesByQuery,
            parameters: ["query": query],
            authorizationToken: DataConstants.apikey)
        
        return networkService.request(endPoint,
                                      queue: .main)
        .map { RecipesMapper.map(input: $0) }
        .eraseToAnyPublisher()
    }
    
    func getDetailRecipe(by id: String) -> AnyPublisher<RecipeDetailObject, Error> {
        let endPoint = NetworkRequest<ApiRecipeDetailResponse>(
            method: .GET,
            relativePath: String(format:DataConstants.WS.getDetail, String(id)),
            parameters: nil,
            authorizationToken: DataConstants.apikey)
        
        return networkService.request(endPoint,
                                      queue: .main)
        .map { DetailRecipeMapper.map(input: $0) }
        .eraseToAnyPublisher()
    }

}
