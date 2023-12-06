//
//  EmptyInitiatorAlertPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class EmptyInitiatorAlertPresenter: EmptyInitiatorAlertModuleInput, EmptyInitiatorAlertViewOutput, EmptyInitiatorAlertInteractorOutput {

    weak var view: EmptyInitiatorAlertViewInput!
    var interactor: EmptyInitiatorAlertInteractorInput!
    var router: EmptyInitiatorAlertRouterInput!

    func viewIsReady() {

    }
    
    func dissmiss() {
        router.dissmiss()
    }
}
