//
//  AdDocumentModuleConfigurator.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class AdDocumentModuleConfigurator {

    func build(factory: ModulesFactory, id: String?) -> AdDocumentViewController {
        let viewController = AdDocumentViewController()
        
        let router = AdDocumentRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = AdDocumentPresenter()
        presenter.router = router
        presenter.id = id

        let interactor = AdDocumentInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
                
        return viewController
    }
}
