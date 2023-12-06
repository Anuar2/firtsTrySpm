//
//  SaveDocumentAlertPresenter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

class SaveDocumentAlertPresenter: SaveDocumentAlertModuleInput, SaveDocumentAlertViewOutput, SaveDocumentAlertInteractorOutput {

    weak var view: SaveDocumentAlertViewInput!
    var interactor: SaveDocumentAlertInteractorInput!
    var router: SaveDocumentAlertRouterInput!

    func viewIsReady() {

    }
    
    func dissmiss() {
        router.dissmiss()
    }
}
