//
//  EndDateCalendarViewRouter.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class EndDateCalendarViewRouter: EndDateCalendarViewRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: EndDateCalendarViewViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showCreateDocFlowView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
}
