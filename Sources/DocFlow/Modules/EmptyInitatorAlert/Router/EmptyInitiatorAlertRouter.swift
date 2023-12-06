//
//  EmptyInitiatorAlertRouter.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class EmptyInitiatorAlertRouter: EmptyInitiatorAlertRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: EmptyInitiatorAlertViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showFilterInitiatorView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: false)
    }
}
