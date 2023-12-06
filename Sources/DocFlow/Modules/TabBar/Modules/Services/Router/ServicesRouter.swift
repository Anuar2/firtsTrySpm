//
//  ServicesRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class ServicesRouter: ServicesRouterInput {
    var factory: ModulesFactory
    
    weak var viewController: ServicesViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showServicesView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showDocumentListView() {
        guard let viewController = viewController else {return}
        let documentListView = factory.makeDocumentList()
        documentListView.navigationItem.hidesBackButton = true
        viewController.navigationController?.pushViewController(documentListView, animated: true)
    }
}
