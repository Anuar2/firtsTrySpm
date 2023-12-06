//
//  SaveDocumentAlertRouter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class SaveDocumentAlertRouter: SaveDocumentAlertRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: SaveDocumentAlertViewController?
    
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
