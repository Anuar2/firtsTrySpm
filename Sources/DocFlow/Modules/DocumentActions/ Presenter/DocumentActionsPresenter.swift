//
//  DocumentActionsPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class DocumentActionsPresenter: DocumentActionsModuleInput, DocumentActionsInteractorOutput {

    weak var view: DocumentActionsViewInput?
    var interactor: DocumentActionsInteractorInput?
    var router: DocumentActionsRouterInput?
    
    func viewIsReady() {

    }
}

extension DocumentActionsPresenter: DocumentActionsViewOutput {
    func deleteDocument(document: DocumentViewModel) {
        router?.presentDeleteDocumentAlert(document: document)
    }
    
    func showEditAdDocumentInfoView(id: String?) {
        router?.showEditAdDocumentInfoView(id: id)
    }
    
    func dissmiss() {
        router?.dissmiss()
    }
    
    func presentEditDociment() {
        router?.presentEditDocumentAlert()
    }
    
    func downloadDocument(document: DocumentViewModel) {
        guard let url = URL(string: document.documentLink ?? "") else {
            return
        }
        
        let destinationURL = createDestinationURL(for: url.appendingPathExtension("docx"))


         if FileManager.default.fileExists(atPath: destinationURL.path) {
             router?.showDownloadShareAlert(for: destinationURL)
         }
    }
    private func createDestinationURL(for originalURL: URL) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = originalURL.lastPathComponent
        let destinationURL = documentsDirectory.appendingPathComponent(fileName)
        return destinationURL
    }
}
