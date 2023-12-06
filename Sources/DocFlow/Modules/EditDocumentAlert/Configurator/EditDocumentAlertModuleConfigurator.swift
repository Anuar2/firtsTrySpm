//
//  EditDocumentAlertModuleConfigurator.swift
//  
//
//  Created by User on 05.12.2023.
//

import UIKit

class EditDocumentAlertModuleConfigurator {
    func build(factory: ModulesFactory) -> EditDocumentAlertViewController {
        let viewController = EditDocumentAlertViewController()
        let router = EditDocumentAlertRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = EditDocumentAlertPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = EditDocumentAlertInteractor()
        interactor.output = presenter

        viewController.output = presenter
                
        return viewController
    }
}
