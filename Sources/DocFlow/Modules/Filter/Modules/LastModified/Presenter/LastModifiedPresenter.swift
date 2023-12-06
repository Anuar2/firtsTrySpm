//
//  File.swift
//  
//
//  Created by User on 05.12.2023.
//

import Foundation

class LastModifiedPresenter: LastModifiedModuleInput, LastModifiedViewOutput, LastModifiedInteractorOutput {

    weak var view: LastModifiedViewInput!
    var interactor: LastModifiedInteractorInput!
    var router: LastModifiedRouterInput!

    func viewIsReady() {

    }
}
