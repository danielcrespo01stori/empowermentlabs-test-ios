//
//  empowermentLabsApp.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import SwiftUI

@main
struct empowermentLabsApp: App {
    let factory = Factory()
    var body: some Scene {
        WindowGroup {
            RecipesView<RecipesViewModel>()
        }
    }
}
