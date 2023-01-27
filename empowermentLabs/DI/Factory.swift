//
//  Factory.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import Resolver

class Factory {
    
    init() {
        Resolver.RegisterModuleDependencies(with: DataConstants.baseUrl)
    }
}
