//
//  GetRecipesByQueryUseCaseStub.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Combine
import Foundation
@testable import empowermentLabs

class GetRecipesByQueryUseCaseStub: AnyUseCase<String, [RecipeObject]> {
        
    static var recipes = [
        RecipeObject(
            id: "",
            title: "",
            image: "",
            imageType: nil
        )
    ]
    
    static var error: Error?
    
    override func execute(params: String) -> AnyPublisher<[RecipeObject], Error> {
        let publisher = CurrentValueSubject<[RecipeObject], Error>(GetRecipesByQueryUseCaseStub.recipes)
        if let error = GetRecipesByQueryUseCaseStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
}
