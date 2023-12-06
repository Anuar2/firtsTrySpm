//
//  File.swift
//  
//
//  Created by User on 05.12.2023.
//

import UIKit

class DocTypeModuleConfigurator {
    func build(factory: ModulesFactory) -> DocTypeViewController {
        let viewController = DocTypeViewController()
        
        let router = DocTypeRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = DocTypePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = DocTypeInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
