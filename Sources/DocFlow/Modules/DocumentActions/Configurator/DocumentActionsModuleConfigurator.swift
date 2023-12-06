//
//  DocumentActionsModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class DocumentActionsModuleConfigurator {
    func build(factory: ModulesFactory, documentViewModel: DocumentViewModel) -> DocumentActionsViewController {
        let viewController = DocumentActionsViewController(document: documentViewModel)
        
        let router = DocumentActionsRouter(factory: factory)
        router.viewController = viewController
        
        let presenter = DocumentActionsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = DocumentActionsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
                
        return viewController
    }
}
