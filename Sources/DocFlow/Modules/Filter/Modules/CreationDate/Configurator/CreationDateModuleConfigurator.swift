//
//  CreationDateModuleConfigurator.swift
//  
//
//  Created by User on 05.12.2023.
//

import UIKit

class CreationDateModuleConfigurator {
    func build(factory: ModulesFactory) -> CreationDateViewController {
        let viewController = CreationDateViewController()
        
        let router = CreationDateRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = CreationDatePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CreationDateInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
