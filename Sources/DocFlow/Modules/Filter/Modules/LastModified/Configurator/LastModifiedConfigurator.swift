//
//  LastModifiedConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class LastModifiedConfigurator {
    func build(factory: ModulesFactory) -> LastModifiedViewController {
        let viewController = LastModifiedViewController()
        
        let router = LastModifiedRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = LastModifiedPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = LastModifiedInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
