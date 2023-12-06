//
//  SearchModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class SearchModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let viewController = SearchViewController()
        
        let router = SearchRouter(factory: factory)
        router.viewController = viewController
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor, router: router)

        viewController.presenter = presenter
                
        return viewController
    }
}

