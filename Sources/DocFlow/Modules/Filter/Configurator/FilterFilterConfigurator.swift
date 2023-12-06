//
//  FilterFilterConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

import UIKit

class FilterModuleConfigurator {
    func build(factory: ModulesFactory) -> FilterViewController {
        let viewController = FilterViewController()
        
        let router = FilterRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = FilterPresenter()
        presenter.router = router

        let interactor = FilterInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
                
        return viewController
    }
}
