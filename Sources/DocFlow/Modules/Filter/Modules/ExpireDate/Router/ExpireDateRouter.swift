//
//  ExpireDateRouter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class ExpireDateRouter: ExpireDateRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: ExpireDateViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showCreationDateView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
