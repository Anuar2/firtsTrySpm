//
//  FilterInitiatorModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class FilterInitiatorModuleConfigurator {
    func build(factory: ModulesFactory) -> FilterInitiatorViewController {
        let viewController = FilterInitiatorViewController()
        
        let router = FilterInitiatorRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = FilterInitiatorPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = FilterInitiatorInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter

        return viewController
    }
}
