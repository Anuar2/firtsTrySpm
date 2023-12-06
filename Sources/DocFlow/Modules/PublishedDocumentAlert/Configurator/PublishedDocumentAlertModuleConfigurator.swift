//
//  PublishedDocumentAlertModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class PublishedDocumentAlertModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let viewController = PublishedDocumentAlertViewController()
        let router = PublishedDocumentAlertRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = PublishedDocumentAlertPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = PublishedDocumentAlertInteractor()
        interactor.output = presenter

        viewController.output = presenter
                
        return viewController
    }
}
