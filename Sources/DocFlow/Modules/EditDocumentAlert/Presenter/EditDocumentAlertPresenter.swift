//
//  EditDocumentAlertPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class EditDocumentAlertPresenter: EditDocumentAlertModuleInput, EditDocumentAlertViewOutput, EditDocumentAlertInteractorOutput {

    weak var view: EditDocumentAlertViewInput!
    var interactor: EditDocumentAlertInteractorInput!
    var router: EditDocumentAlertRouterInput!

    func viewIsReady() {

    }
    
    func dissmiss() {
        router.dissmiss()
    }
}
