//
//  LastModifiedRouter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class LastModifiedRouter: LastModifiedRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: LastModifiedViewController?
    
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
