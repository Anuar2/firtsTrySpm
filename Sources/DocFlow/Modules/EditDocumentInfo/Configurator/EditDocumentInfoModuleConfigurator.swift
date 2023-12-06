//
//  EditDocumentInfoModuleConfigurator.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class EditDocumentInfoModuleConfigurator {
    func build(factory: ModulesFactory, data: Data?, model: DocumentViewModel?, documentURL: URL?) -> UIViewController {
        let viewController = EditDocumentInfoViewController(pdfData: data, documentURL: documentURL)
        
        let router = EditDocumentInfoRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = EditDocumentInfoPresenter()
        presenter.router = router
        presenter.viewmodel = model

        let interactor = EditDocumentInfoInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
                
        return viewController
    }
}
