//
//  UploadDocumentPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class UploadDocumentPresenter: UploadDocumentModuleInput, UploadDocumentInteractorOutput {
    func sendUploadDocument(_ model: UploadDocument) {
        view?.sendUploadDocument(model)
    }
    

    weak var view: UploadDocumentViewInput?
    var interactor: UploadDocumentInteractorInput?
    var router: UploadDocumentRouterInput?

    func viewIsReady() {

    }
}

extension UploadDocumentPresenter: UploadDocumentViewOutput {
    func presentDocumentPicker() {
        router?.showDocumentPicker()
    }
    
    func dissmiss() {
        router?.dissmiss()
    }
    
    func uploadDocument(with data: Data?) {
        interactor?.uploadDocument(with: data)
    }
}
