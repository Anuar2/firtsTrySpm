//
//  ChatsRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class ChatsRouter: ChatsRouterInput {
    var factory: ModulesFactory
    
    var router = DependencyContainer.shared.resolve(DFRouter.self)
    
    weak var viewController: ChatsViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showChatsView() {
        guard let router = router, let viewController = viewController else {return}
        
        router.push(viewController)
    }
}
