//
//  HomeModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class HomeModuleConfigurator {

    func build(factory: ModulesFactory) -> UIViewController {
        let router = HomeRouter(factory: factory)
        let viewController = HomeViewController()

        let presenter = HomePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = HomeInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }

}
