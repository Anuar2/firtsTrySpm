//
//  TabBarRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class TabBarRouter: TabBarRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: TabBarViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showTabBarView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
