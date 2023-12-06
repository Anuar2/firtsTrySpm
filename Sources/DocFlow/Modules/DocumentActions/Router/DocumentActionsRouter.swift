//
//  DocumentActionsRouter.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class DocumentActionsRouter {
    var factory: ModulesFactory
    
    weak var viewController: DocumentActionsViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showDocumentActionsView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - SearchRouterInput
extension DocumentActionsRouter: DocumentActionsRouterInput {
    func showEditAdDocumentInfoView(id: String?) {
        let editAdDetailVC = factory.makeEditAdDocumentInfoView(id: id)
        viewController?.present(editAdDetailVC, animated: true)
    }
    
    func showDownloadShareAlert(for fileURL: URL) {
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController as? UIView
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        activityViewController.popoverPresentationController?.permittedArrowDirections = .any
        viewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
    
    func presentEditDocumentAlert() -> UIViewController {
        guard let viewController = viewController else { return UIViewController() }
        
        let popUpVC = factory.makeEditDocumentAlertView()
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.delegate = viewController
        
        viewController.present(popUpVC, animated: false)
        return popUpVC
    }
    
    func presentDeleteDocumentAlert(document: DocumentViewModel) -> UIViewController {
        guard let viewController = viewController else { return UIViewController() }

        let popUpVC = factory.makeDeleteDocumentAlertView(id: document.id)
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.delegate = viewController
        
        viewController.present(popUpVC, animated: false)
        return popUpVC
    }
}
