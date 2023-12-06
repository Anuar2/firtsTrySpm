//
//  CreateDocFlowConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class CreateDocFlowConfigurator {
    func build(factory: ModulesFactory, with data: Data?, documentURL: URL?) -> UIViewController {
        let viewController = CreateDocFlowViewController()
        viewController.pdfData = data
        viewController.documentURL = documentURL
        let router = CreateDocFlowRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = CreateDocFlowPresenter()
        presenter.router = router

        let interactor = CreateDocFlowInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.presenter = presenter
                
        return viewController
    }
}
