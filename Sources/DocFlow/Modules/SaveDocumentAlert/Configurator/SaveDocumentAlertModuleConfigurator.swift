//
//  SaveDocumentAlertModuleConfigurator.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class SaveDocumentAlertModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let viewController = SaveDocumentAlertViewController()
        let router = SaveDocumentAlertRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = SaveDocumentAlertPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SaveDocumentAlertInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
