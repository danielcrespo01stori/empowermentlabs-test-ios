//
//  FavoritesContract.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation
import SwiftUI

protocol FavoritesViewModelType: ObservableObject {
    var state: FavoritesState { get set }
    func onAppear()
    func deleteRecipe(with id: String)
    func onDisAppear()
}
