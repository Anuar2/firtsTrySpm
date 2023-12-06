//
//  UploadDocumentModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class UploadDocumentModuleConfigurator {
    func build(factory: ModulesFactory) -> UIViewController {
        let viewController = UploadDocumentViewController()
        
        let router = UploadDocumentRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = UploadDocumentPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = UploadDocumentInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
