//
//  UploadDocumentRouter.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class UploadDocumentRouter {
    var factory: ModulesFactory
    
    weak var viewController: UploadDocumentViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showUploadDocumentView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - SearchRouterInput
extension UploadDocumentRouter: UploadDocumentRouterInput {
    func showDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = viewController as? UIDocumentPickerDelegate
        viewController?.present(documentPicker, animated: true)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true)
    }
}
