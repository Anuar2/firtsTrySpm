//
//  AdDocumentInteractor.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

class AdDocumentInteractor: AdDocumentInteractorInput {
    weak var output: AdDocumentInteractorOutput?
    private let service = NetworkManager()

    func requestDocument(by id: String) {
        service.request(DocumentsApi.getDocument(id: id), model: DocumentTemp.self) { [ weak self] model, error in
            if let error = error {
                print(error)
            }
            
            if let model = model {
                print(model)
                self?.output?.documentIsLoaded(model)
            }
        }
    }
    
    func requestAttachment(by id: String) {
        service.request(DocumentsApi.getAttachment(id: id), model: AttachmentModel.self) { [ weak self] model, error in
            if let error = error {
                print(error)
            }
            
            if let model = model {
                self?.output?.attachmentIsLoaded(model)
            }
        }
    }
}
