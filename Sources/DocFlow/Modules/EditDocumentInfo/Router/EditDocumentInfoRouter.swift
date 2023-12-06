//
//  EditDocumentInfoRouter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class EditDocumentInfoRouter {
    var factory: ModulesFactory
    
    weak var viewController: EditDocumentInfoViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showFilterInitiatorView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
}

extension EditDocumentInfoRouter: EditDocumentInfoRouterInput {
    func showInitiatorsView() {
        let initiatorsVC = factory.makeFilterInitiatorView()
        initiatorsVC.delegate = viewController
        viewController?.present(initiatorsVC, animated: true)
    }
    
    func presentPopUp() -> UIViewController {
        guard let viewController = viewController else { return UIViewController() }
        
        let popUpVC = factory.makePublishedDocumentAlertView()
        popUpVC.modalPresentationStyle = .overFullScreen

        viewController.present(popUpVC, animated: false)
        
        return popUpVC
    }
    
    func presentPopUpFull() -> UIViewController {
        guard let viewController = viewController else { return UIViewController() }
        
        let popUpVC = factory.makeFullPublishedDocumentAlertView()
        popUpVC.modalPresentationStyle = .overFullScreen
        
        viewController.present(popUpVC, animated: false)
        
        return popUpVC
    }
    
    func presentPopUpEmptyInitiator() -> UIViewController {
        guard let viewController = viewController else { return UIViewController() }
        
        let popUpVC = factory.makeEmptyInitiatorAlertView()
        popUpVC.modalPresentationStyle = .overFullScreen
        
        viewController.present(popUpVC, animated: false)
        return popUpVC
    }
}
