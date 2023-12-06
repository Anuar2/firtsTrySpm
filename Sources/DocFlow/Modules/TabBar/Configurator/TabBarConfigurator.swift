//
//  TabBarConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class TabBarModuleConfigurator {

    func build(factory: ModulesFactory) -> UITabBarController {
        let viewController = TabBarViewController()
        
        let router = TabBarRouter(factory: factory)
        router.viewController = viewController

        let presenter = TabBarPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = TabBarInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
