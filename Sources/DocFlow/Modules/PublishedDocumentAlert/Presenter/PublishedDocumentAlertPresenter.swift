//
//  PublishedDocumentAlertPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class PublishedDocumentAlertPresenter: PublishedDocumentAlertModuleInput, PublishedDocumentAlertViewOutput, PublishedDocumentAlertInteractorOutput {

    weak var view: PublishedDocumentAlertViewInput!
    var interactor: PublishedDocumentAlertInteractorInput!
    var router: PublishedDocumentAlertRouterInput!

    func viewIsReady() {

    }
    
    func dissmiss() {
        router.dissmiss()
    }
}
