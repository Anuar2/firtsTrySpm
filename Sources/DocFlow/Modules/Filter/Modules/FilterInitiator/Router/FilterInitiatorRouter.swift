//
//  FilterInitiatorRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class FilterInitiatorRouter: FilterInitiatorRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: FilterInitiatorViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showFilterInitiatorView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
}
