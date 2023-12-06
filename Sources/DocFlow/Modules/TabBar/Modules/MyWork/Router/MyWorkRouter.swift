//
//  MyWorkRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class MyWorkRouter: MyWorkRouterInput {
    var factory: ModulesFactory
    
    var router = DependencyContainer.shared.resolve(DFRouter.self)
    
    weak var viewController: MyWorkViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showMyWorkView() {
        guard let router = router, let viewController = viewController else {return}
        
        router.push(viewController)
    }
}
