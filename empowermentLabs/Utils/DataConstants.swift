//
//  DataConstants.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

struct DataConstants {
    enum APIClient {
        static let contentType = "Content-Type"
        static let xApiKey = "X-API-Key"
    }
    
    enum InnerConstants {
        static let applicationJson = "application/json"
    }
    struct WS {
        static let getRecipesByQuery = "/recipes/complexSearch"
        static let getDetail = "/recipes/%@/information"
    }
    
    struct resource {
        static let smallImage = "https://spoonacular.com/cdn/ingredients_100x100/"
    }
    
    static let baseUrl = "https://api.spoonacular.com"
    static let apikey: String = "9204cc61ce854b32961bfc77d444ceaa"
}
