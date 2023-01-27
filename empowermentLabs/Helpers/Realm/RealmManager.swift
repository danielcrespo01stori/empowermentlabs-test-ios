//
//  RealmManager.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject ,RealmManagerType {
    var localRealm: RealmSwift.Realm?
    
    init() {
        openRealm()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening realm: \(error)")
        }
    }
}
