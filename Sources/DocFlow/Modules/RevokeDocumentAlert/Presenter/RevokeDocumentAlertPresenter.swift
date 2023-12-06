//
//  RevokeDocumentAlertPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class RevokeDocumentAlertPresenter: RevokeDocumentAlertModuleInput, RevokeDocumentAlertViewOutput, RevokeDocumentAlertInteractorOutput {

    weak var view: RevokeDocumentAlertViewInput?
    var interactor: RevokeDocumentAlertInteractorInput?
    var router: RevokeDocumentAlertRouterInput?
    
    var id: String?

    func viewIsReady() {
        
    }
    
    func revokeRequest() {
        guard let id = id else { return }
        interactor?.deleteDocument(id: id)
    }
    
    func dissmiss() {
        router?.dissmiss()
    }
}
