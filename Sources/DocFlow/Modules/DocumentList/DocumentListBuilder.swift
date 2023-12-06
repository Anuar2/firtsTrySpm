//
//  DocumentListBuilder.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

public final class DocumentListBuilder {
    
    func build(factory: ModulesFactory) -> UIViewController {
        let router = DocumentListRouter(factory: factory)
        let interactor = DocumentListInteractor()
        let presenter = DocumentListPresenter(interactor: interactor, router: router)
        let viewController = DocumentListViewController()
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationController?.navigationBar.backgroundColor = .red
        viewController.navigationController?.toolbar.backgroundColor = .red
        return viewController
    }
}

