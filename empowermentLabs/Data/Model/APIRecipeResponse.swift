//
//  APIRecipeResponse.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

struct APIRecipeResponse: Codable {
    var id: Int
    var title: String
    var image: String
    var imageType: String
    
    init(id: Int,
         title: String,
         image: String,
         imageType: String) {
        self.id = id
        self.title = title
        self.image = image
        self.imageType = imageType
    }
}
