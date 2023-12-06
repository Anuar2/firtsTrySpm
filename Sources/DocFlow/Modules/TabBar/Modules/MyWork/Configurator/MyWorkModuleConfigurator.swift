//
//  MyWorkModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class MyWorkModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let router = MyWorkRouter(factory: factory)
        let viewController = MyWorkViewController()

        let presenter = MyWorkPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = MyWorkInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }
}
