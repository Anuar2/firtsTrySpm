//
//  TeamRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class TeamRouter: TeamRouterInput {
    var factory: ModulesFactory
    
    var router = DependencyContainer.shared.resolve(DFRouter.self)
    
    weak var viewController: TeamViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showTeamView() {
        guard let router = router, let viewController = viewController else {return}
        
        router.push(viewController)
    }
}
