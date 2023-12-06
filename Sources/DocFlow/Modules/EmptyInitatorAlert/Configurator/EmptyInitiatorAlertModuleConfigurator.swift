//
//  EmptyInitiatorAlertModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class EmptyInitiatorAlertModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let viewController = EmptyInitiatorAlertViewController()
        let router = EmptyInitiatorAlertRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = EmptyInitiatorAlertPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = EmptyInitiatorAlertInteractor()
        interactor.output = presenter

        viewController.output = presenter
                
        return viewController
    }
}
