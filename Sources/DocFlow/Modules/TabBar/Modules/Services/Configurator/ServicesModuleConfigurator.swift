//
//  ServicesModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class ServicesModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let viewController = ServicesViewController()
        
        let router = ServicesRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = ServicesPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ServicesInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
