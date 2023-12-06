//
//  RevokeDocumentAlertModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class RevokeDocumentAlertModuleConfigurator {
    func build(factory: ModulesFactory, id: String) -> RevokeDocumentAlertViewController {
        let viewController = RevokeDocumentAlertViewController()
        let router = RevokeDocumentAlertRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = RevokeDocumentAlertPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.id = id

        let interactor = RevokeDocumentAlertInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
