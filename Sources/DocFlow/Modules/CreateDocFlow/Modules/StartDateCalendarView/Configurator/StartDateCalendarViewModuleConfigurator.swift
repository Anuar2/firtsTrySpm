//
//  StartDateCalendarViewModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class StartDateCalendarViewModuleConfigurator {
    func build(factory: ModulesFactory) -> StartDateCalendarViewViewController {
        let viewController = StartDateCalendarViewViewController()
        
        let router = StartDateCalendarViewRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = StartDateCalendarViewPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = StartDateCalendarViewInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
