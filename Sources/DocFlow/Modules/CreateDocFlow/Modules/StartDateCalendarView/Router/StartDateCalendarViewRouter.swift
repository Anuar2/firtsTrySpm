//
//  StartDateCalendarViewRouter.swift
//  
//
//  Created by User on 05.12.2023.
//

class StartDateCalendarViewRouter: StartDateCalendarViewRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: StartDateCalendarViewViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showCreateDocFlowView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
