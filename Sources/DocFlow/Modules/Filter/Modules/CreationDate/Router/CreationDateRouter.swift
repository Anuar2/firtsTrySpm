//
//  CreationDateRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class CreationDateRouter: CreationDateRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: CreationDateViewController?
    
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
