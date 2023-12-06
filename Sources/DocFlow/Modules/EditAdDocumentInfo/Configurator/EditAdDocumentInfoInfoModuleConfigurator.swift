//
//  EditAdDocumentInfoInfoModuleConfigurator.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class EditAdDocumentInfoInfoModuleConfigurator {

    func build(factory: ModulesFactory, id: String?) -> EditAdDocumentInfoViewController {
        let viewController = EditAdDocumentInfoViewController()
        
        let router = EditAdDocumentInfoRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = EditAdDocumentInfoPresenter()
        presenter.router = router
        presenter.id = id

        let interactor = EditAdDocumentInfoInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
                
        return viewController
    }
}
