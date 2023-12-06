//
//  DeleteDocumentAlertModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class DeleteDocumentAlertModuleConfigurator {
    func build(factory: ModulesFactory, id: String) -> DeleteDocumentAlertViewController {
        let viewController = DeleteDocumentAlertViewController()
        let router = DeleteDocumentAlertRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = DeleteDocumentAlertPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.id = id

        let interactor = DeleteDocumentAlertInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
