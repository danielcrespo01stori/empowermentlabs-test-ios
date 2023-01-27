//
//  BaseViewModelProtocol.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

protocol BaseViewModelProtocol {
    
    var view: BaseView? {get set}
    
    func bind(withView view: BaseView)
    func unBind()
    func viewAppear()
    func viewDidAppear()
    func getInitialState()
}
