//
//  DocTypeRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class DocTypeRouter: DocTypeRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: DocTypeViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showDocTypeView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
