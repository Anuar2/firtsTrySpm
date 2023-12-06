//
//  EndDateCalendarViewModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class EndDateCalendarViewModuleConfigurator {
    func build(factory: ModulesFactory) -> EndDateCalendarViewViewController {
        let viewController = EndDateCalendarViewViewController()
        
        let router = EndDateCalendarViewRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = EndDateCalendarViewPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = EndDateCalendarViewInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
