//
//  RealmManagerType.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Foundation
import RealmSwift

protocol RealmManagerType {
    var localRealm: Realm? { get set }
    func openRealm()
}
