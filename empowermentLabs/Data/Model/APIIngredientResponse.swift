//
//  APIIngredientResponse.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

struct APIIngredientResponse: Codable {
    var id: Int
    var name: String
    var original: String
    var image: String
    
    init(
        id: Int,
        name: String,
        original: String,
        image: String) {
        self.id = id
        self.name = name
        self.original = original
        self.image = image
    }
}
