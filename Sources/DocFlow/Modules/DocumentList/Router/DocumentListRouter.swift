//
//  DocumentListRouter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import FloatingPanel

protocol DocumentListRouterProtcol: AnyObject {
    func showDocumentListView()
    func presentDocumentPicker() -> UIViewController
    func showPDFView(with data: Data?)
    func showCreateDocFlow(with data: Data?, documentURL: URL?)
    func dismissPDFView()
    func presentFilterView()
    func presentSearchView()
    func showAdDocumentView(with id: String?)
    func dissmiss()
}

class DocumentListRouter {
    
    // MARK: - Properties
    
    var factory: ModulesFactory
    
    weak var viewController: DocumentListViewController?
    
    //MARK: - Init
    init(factory: ModulesFactory) {
        self.factory = factory
    }
}

//MARK: - DocumentListRouterProtcol
extension DocumentListRouter: DocumentListRouterProtcol {
    func dissmiss() {
        guard let viewController = viewController else {return}
        
        viewController.dismiss(animated: true)
    }
    func showDocumentListView() {
        guard let viewController = viewController else {return}
        
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showCreateDocFlow(with data: Data?, documentURL: URL?) {
        let docFlowVC = factory.makeCreateDocFlow(with: data, documentURL: documentURL)
        let navigationController = UINavigationController(rootViewController: docFlowVC)
        viewController?.present(navigationController, animated: true)
    }
    
    func presentDocumentPicker() -> UIViewController {
//        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
//        documentPicker.delegate = viewController as? UIDocumentPickerDelegate
//        documentPicker.allowsMultipleSelection = true
        let uploadDocumentVC = factory.makeUploadDocumentView()
        
        viewController?.present(uploadDocumentVC, animated: true)
        
//        let docActions = factory.makeDocumentActionsView()
//
//        viewController?.present(docActions, animated: true)
        return uploadDocumentVC
    }
    
    func showPDFView(with data: Data?) {
        let pdfViewController = factory.makePDFFileView(with: data)
        viewController?.navigationController?.present(pdfViewController, animated: true)
    }
    
    func dismissPDFView() {
        viewController?.navigationController?.dismiss(animated: true)
    }
    
    func presentFilterView() {
        let filterView = factory.makeFilterView()
        filterView.delegate = viewController
        viewController?.present(filterView, animated: true)
    }
    
    func presentSearchView() {
        let searchView = factory.makeSearchView()
        viewController?.navigationController?.present(searchView, animated: true)
    }
    
    func showAdDocumentView(with id: String?) {
        let adDetailVC = factory.makeAdDocumentView(id: id)
        adDetailVC.delegate = viewController
        viewController?.present(adDetailVC, animated: true)
    }
}

