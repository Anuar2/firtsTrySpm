//
//  EditAdDocumentInfoRouter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class EditAdDocumentInfoRouter {
    var factory: ModulesFactory
    
    weak var viewController: EditAdDocumentInfoViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showFilterInitiatorView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension EditAdDocumentInfoRouter: EditAdDocumentInfoRouterInput {
    func dissmiss() {
        viewController?.dismiss(animated: true)
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
    
    func showDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = viewController as? UIDocumentPickerDelegate
        viewController?.present(documentPicker, animated: true)
    }
    
    func showInitiatorsView() {
        let initiatorsVC = factory.makeFilterInitiatorView()
        initiatorsVC.delegate = viewController
        viewController?.present(initiatorsVC, animated: true)
    }
    
    func presentPopUpEmptyInitiator() -> UIViewController {
        guard let viewController = viewController else { return UIViewController() }
        
        let popUpVC = factory.makeEmptyInitiatorAlertView()
        popUpVC.modalPresentationStyle = .overFullScreen
        
        viewController.present(popUpVC, animated: false)
        return popUpVC
    }
    
    func showStartDateView() {
        let startVC = factory.makeStartDateCalendarView()
        startVC.delegate = viewController
        viewController?.present(startVC, animated: true)
    }
    
    func showEndDateView() {
        let endVC = factory.makeEndDateCalendarView()
        endVC.delegate = viewController
        viewController?.present(endVC, animated: true)
    }
}
