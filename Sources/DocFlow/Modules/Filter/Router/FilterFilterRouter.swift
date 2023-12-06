//
//  FilterFilterRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class FilterRouter {
    var factory: ModulesFactory
    
    weak var viewController: FilterViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showFilterView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - FilterRouterInput
extension FilterRouter: FilterRouterInput {
    func presentDocTypeView() {
        guard let viewController = viewController else {return}
        
        let docTypeViewController = factory.makeDocTypeView()
        docTypeViewController.delegate = viewController
        viewController.present(docTypeViewController, animated: true)
    }
    
    func presentFilterInitiatorView() {
        guard let viewController = viewController else {return}
        
        let initiatorViewController = factory.makeFilterInitiatorView()
        initiatorViewController.delegate = viewController
        viewController.present(initiatorViewController, animated: true)
    }
    
    func presentCreationDateView() {
        guard let viewController = viewController else {return}
        
        let creationDateViewController = factory.makeCreationDateView()
        creationDateViewController.delegate = viewController
        viewController.present(creationDateViewController, animated: true)
    }
    
    func presentExpireDateView() {
        guard let viewController = viewController else {return}
        
        let expireDateViewController = factory.makeExpireDateView()
        expireDateViewController.delegate = viewController
        viewController.present(expireDateViewController, animated: true)
    }
    
    func presentLastModifitedView() {
        guard let viewController = viewController else {return}

        let lastModifiedViewController = factory.makeLastModifiedView()
        lastModifiedViewController.delegate = viewController
        viewController.present(lastModifiedViewController, animated: true)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
}
