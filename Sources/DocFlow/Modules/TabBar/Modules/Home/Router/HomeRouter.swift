//
//  HomeRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class HomeRouter: HomeRouterInput {
    var factory: ModulesFactory
    
    var router = DependencyContainer.shared.resolve(DFRouter.self)
    
    weak var viewController: HomeViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showHomeView() {
        guard let router = router, let viewController = viewController else {return}
        
        router.push(viewController)
    }
}
