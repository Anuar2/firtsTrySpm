//
//  SearchRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class SearchRouter {
    var factory: ModulesFactory
    
    weak var viewController: SearchViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showFilterView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - SearchRouterInput
extension SearchRouter: SearchRouterInput {
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
}
