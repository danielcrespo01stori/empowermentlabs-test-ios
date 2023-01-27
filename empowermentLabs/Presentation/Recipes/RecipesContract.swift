//
//  RecipesContract.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import SwiftUI

protocol RecipesViewModelType: ObservableObject {
    var state: RecipesState { get set }
    func onAppear(query: String)
    func onDisAppear()
}
