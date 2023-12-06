//
//  FullPublishedDocumentAlertModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class FullPublishedDocumentAlertModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let viewController = FullPublishedDocumentAlertViewController()
        let router = FullPublishedDocumentAlertRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = FullPublishedDocumentAlertPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = FullPublishedDocumentAlertInteractor()
        interactor.output = presenter

        viewController.output = presenter
                
        return viewController
    }
}
