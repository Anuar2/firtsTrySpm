//
//  ChatsModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class ChatsModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let router = ChatsRouter(factory: factory)
        let viewController = ChatsViewController()

        let presenter = ChatsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ChatsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
