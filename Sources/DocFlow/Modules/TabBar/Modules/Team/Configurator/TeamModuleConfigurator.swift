//
//  TeamModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class TeamModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {

        let router = TeamRouter(factory: factory)
        let viewController = TeamViewController()

        let presenter = TeamPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = TeamInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }

}
