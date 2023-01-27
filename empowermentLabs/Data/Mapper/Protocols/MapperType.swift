//
//  MapperType.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

protocol MapperType {
    associatedtype Input
    associatedtype Output
    
    static func map(input: Input) -> Output
}
