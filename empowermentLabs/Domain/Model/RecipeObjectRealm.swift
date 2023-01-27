//
//  RecipeObjectRealm.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Foundation
import RealmSwift

class RecipeObjectRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var image: String
}
