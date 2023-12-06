//
//  ExpireDateConfigurator.swift
//  
//
//  Created by User on 05.12.2023.
//

import Foundation

class ExpireDateConfigurator {
    func build(factory: ModulesFactory) -> ExpireDateViewController {
        let viewController = ExpireDateViewController()
        
        let router = ExpireDateRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = ExpireDatePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ExpireDateInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
