//
//  AdDocumentRouter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class AdDocumentRouter {
    var factory: ModulesFactory
    
    weak var viewController: AdDocumentViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showFilterInitiatorView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension AdDocumentRouter: AdDocumentRouterInput {
    
    func presentDocumentActions(documentViewModel: DocumentViewModel) -> UIViewController {
        let docActions = factory.makeDocumentActionsView(documentViewModel: documentViewModel)
        docActions.delegate = viewController
        viewController?.present(docActions, animated: true)
        return docActions
    }

    func showEditAdDocumentInfoView(id: String?) {
        let editAdDetailVC = factory.makeEditAdDocumentInfoView(id: id)
        editAdDetailVC.modalPresentationStyle = .fullScreen
        viewController?.present(editAdDetailVC, animated: true)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
}
