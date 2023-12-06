//
//  AdDocumentPresenter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

class AdDocumentPresenter: AdDocumentPresenterInputProtocol {
    
    var output: AdDocumentPresenterOutputProtocol?
    var id: String?
    
    var interactor: AdDocumentInteractorInput?
    var router: AdDocumentRouterInput?
    
    func viewIsReady() {
        interactor?.output = self
        
        guard let id = id else { return }
        interactor?.requestDocument(by: id)
    }
    
    func dissmiss() {
        router?.dissmiss()
    }

    func documentActions(documentViewModel: DocumentViewModel) {
        router?.presentDocumentActions(documentViewModel: documentViewModel)
    }
    
    func getAttchment(id: String) {
        interactor?.output = self
        interactor?.requestAttachment(by: id)
    }
    
    func showEditAdDocumentInfoView() {
        router?.showEditAdDocumentInfoView(id: self.id)
    }
}

// MARK: - Interactor
extension AdDocumentPresenter: AdDocumentInteractorOutput {
    func documentIsLoaded(_ model: DocumentTemp) {
        DispatchQueue.main.async {
            self.output?.presentViewModel(model.toViewModel(with: "MMM d, yyyy"))
        }
        self.getAttchment(id: model.attachmentID ?? "")
    }
    
    func attachmentIsLoaded(_ model: AttachmentModel) {
        DispatchQueue.main.async {
            self.output?.presentAttachmentLink(link: model.link ?? "")
        }
    }
}
