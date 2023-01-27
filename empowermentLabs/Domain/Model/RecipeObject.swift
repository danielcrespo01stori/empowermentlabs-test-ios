//
//  RecipeObject.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

struct RecipeObject:Identifiable {
    var id: String
    var title: String
    var image: String
    var imageType: String?
    
    init(id: String,
         title: String,
         image: String,
         imageType: String?) {
        self.id = id
        self.title = title
        self.image = image
        self.imageType = imageType
    }
    
    init(recipeObjectRealm: RecipeObjectRealm) {
        self.id = recipeObjectRealm.id
        self.title = recipeObjectRealm.title
        self.image = recipeObjectRealm.image
        self.imageType = nil
    }
}
