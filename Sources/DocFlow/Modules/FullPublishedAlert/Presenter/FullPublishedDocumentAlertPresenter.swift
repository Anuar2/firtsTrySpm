//
//  FullPublishedDocumentAlertPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class FullPublishedDocumentAlertPresenter: FullPublishedDocumentAlertModuleInput, FullPublishedDocumentAlertViewOutput, FullPublishedDocumentAlertInteractorOutput {

    weak var view: FullPublishedDocumentAlertViewInput!
    var interactor: FullPublishedDocumentAlertInteractorInput!
    var router: FullPublishedDocumentAlertRouterInput!

    func viewIsReady() {

    }
    
    func dissmiss() {
        router.dissmiss()
    }
}
