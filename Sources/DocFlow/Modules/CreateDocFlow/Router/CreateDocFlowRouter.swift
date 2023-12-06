//
//  CreateDocFlowRouter.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class CreateDocFlowRouter: CreateDocFlowRouterInput {
    
    var factory: ModulesFactory
    
    weak var viewController: CreateDocFlowViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showCreateDocFlowView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentDocFlowView() {
        guard let viewController = viewController else {return}
        
        let docTypeViewController = factory.makeDocTypeView()
        docTypeViewController.delegate = viewController
        viewController.present(docTypeViewController, animated: true)
    }
    
    func presentSignatoriesView() {
        guard let viewController = viewController else {return}
        
        let initiatorViewController = factory.makeFilterInitiatorView()
        initiatorViewController.delegate = viewController
        viewController.present(initiatorViewController, animated: true)
    }
    
    func presentStartDateCalendarView() {
        guard let viewController = viewController else {return}
        
        let startDateViewController = factory.makeStartDateCalendarView()
        startDateViewController.delegate = viewController
        viewController.present(startDateViewController, animated: true)
    }
    
    func presentEndDateCalendarView() {
        guard let viewController = viewController else {return}

        let endDateViewController = factory.makeEndDateCalendarView()
        endDateViewController.delegate = viewController
        viewController.present(endDateViewController, animated: true)
    }
    
    func presentPopUp() -> UIViewController {
        guard let viewController = viewController else { return UIViewController() }
        
        let popUpVC = factory.makeSaveDocumentAlertView()
        popUpVC.modalPresentationStyle = .overFullScreen

        viewController.present(popUpVC, animated: false)
        
        return popUpVC
    }
    
    func showEditDocView(with data: Data?, viewmodel: DocumentViewModel?, documentURL: URL?) {
        guard let viewController = viewController else {return}
        
        let editDocVC = factory.makeEditDocumentInfoView(with: data, model: viewmodel, documentURL: documentURL)
        viewController.navigationController?.pushViewController(editDocVC, animated: true)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
}

// MARK: - SaveDocumentAlertDelegate
extension CreateDocFlowRouter: SaveDocumentAlertDelegate {
    func saveDocument() {
        
    }
}
