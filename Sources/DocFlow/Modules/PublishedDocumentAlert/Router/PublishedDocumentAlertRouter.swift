//
//  PublishedDocumentAlertRouter.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class PublishedDocumentAlertRouter: PublishedDocumentAlertRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: PublishedDocumentAlertViewController?
    
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
