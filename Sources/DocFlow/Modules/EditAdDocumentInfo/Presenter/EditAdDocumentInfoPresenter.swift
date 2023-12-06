//
//  EditAdDocumentInfoPresenter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class EditAdDocumentInfoPresenter: EditAdDocumentInfoPresenterInputProtocol {
    var output: EditAdDocumentInfoPresenterOutputProtocol?
    var attachmentInfo: AttachmentModel?
    var adDocumentInfo: DocumentViewModel?
    var id: String?
    
    var interactor: EditAdDocumentInfoInteractorInput?
    var router: EditAdDocumentInfoRouterInput?

    func viewIsReady() {
        interactor?.output = self
        
        guard let id = id else { return }
        interactor?.requestDocument(by: id)
    }
    
    func dissmiss() {
        router?.dissmiss()
    }
    
    func getAttachment(id: String) {
        interactor?.requestAttachment(by: id)
    }
    
    func updateDocument() {
        guard let model = generateModel(), let id = id else {return}
        interactor?.output = self
        interactor?.updateDocument(id, model)
    }
    
    func presentPopUp() -> UIViewController {
        return router?.presentPopUp() ?? UIViewController()
    }
    
    func presentPopUpFull() -> UIViewController {
        return router?.presentPopUpFull() ?? UIViewController()
    }
    
    func presentDocumentPickerView() {
        router?.showDocumentPicker()
    }
    
    func presentInitiatorView() {
        router?.showInitiatorsView()
    }
    
    func presentPopUpEmptyInitiator() -> UIViewController {
        return router?.presentPopUpEmptyInitiator() ?? UIViewController()
    }

    
    func presentStartDateView() {
        router?.showStartDateView()
    }
    
    func presentEndDateView() {
        router?.showEndDateView()
    }
    
    func userDidTappedOnPublish() {
        guard let id = id else {return}
        
        interactor?.output = self
        interactor?.publishDocument(by: id)
    }
}


extension EditAdDocumentInfoPresenter: EditAdDocumentInfoInteractorOutput {
    func documentIsLoaded(_ model: DocumentTemp) {
        DispatchQueue.main.async {
            self.adDocumentInfo = model.toViewModel(with: "MMM d, yyyy")
            self.output?.presentViewModel(model.toViewModel(with: "MMM d, yyyy"))
        }
        getAttachment(id: model.attachmentID ?? "")
    }
    
    func attachmentIsLoaded(_ model: AttachmentModel) {
        DispatchQueue.main.async {
            self.adDocumentInfo?.documentLink = model.link
            self.attachmentInfo = model
            self.output?.presentAttachmentModel(model)
        }
    }
    
    func documentUpdated(_ model: DocumentViewModel) {
        DispatchQueue.main.async {
            self.adDocumentInfo = model
            self.output?.presentViewModel(model)
        }
    }
    
    func documentPublished() {
        DispatchQueue.main.async {
            self.output?.presentPublishResult(true)
        }
    }
}

extension EditAdDocumentInfoPresenter {
    private func generateModel() -> DocumentToCreateModel? {
        // TODO: - Убрать хардкод
        guard let title = adDocumentInfo?.title,
              let signatories = adDocumentInfo?.signatories?.compactMap({$0.id}).map({"\($0)"}),
              let number = adDocumentInfo?.number,
              let attachmentID = adDocumentInfo?.attachmentID
        else { return nil }
        
        let type = 1
        
        return DocumentToCreateModel(
            attachmentID: attachmentID,
            type: type,
            title: title,
            signingType: "",
            signatories: signatories,
            number: number,
            startDate: createDocumentAdapter(adDocumentInfo?.startDate),
            expiryDate: createDocumentAdapter(adDocumentInfo?.endDate),
            description: adDocumentInfo?.description
        )
    }
    
    private func createDocumentAdapter(_ date: String?) -> String {
        guard let date = date else { return String() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        guard let date = dateFormatter.date(from: date) else { return String() }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
