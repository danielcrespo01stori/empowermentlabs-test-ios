//
//  APIResultResponse.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

struct APIResultResponse: Codable {
    let results: [APIRecipeResponse]
    
    init(results: [APIRecipeResponse]) {
        self.results = results
    }
}
