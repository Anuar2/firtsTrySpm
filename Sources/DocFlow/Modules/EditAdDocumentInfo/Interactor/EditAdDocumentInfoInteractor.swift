//
//  EditAdDocumentInfoInteractor.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

class EditAdDocumentInfoInteractor: EditAdDocumentInfoInteractorInput {

    weak var output: EditAdDocumentInfoInteractorOutput?
    private let service = NetworkManager()

    func requestDocument(by id: String) {
        service.request(DocumentsApi.getDocument(id: id), model: DocumentTemp.self) { [ weak self] model, error in
            if let error = error {
                print(error)
            }
            
            if let model = model {
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
    
    func updateDocument(_ id: String,_ document: DocumentToCreateModel) {
        service.request(DocumentsApi.updateDocument(id: id, model: document.encode() as Parameters), model: DocumentTemp.self) { [weak self] model, error in
            guard let self = self else { return }
            
            if let error = error {
                print(error)
            }
            if let model = model {
                print(model)
                self.output?.documentUpdated(model.toViewModel(with: "MMM d, yyyy"))
            }
        }
    }
    
    func publishDocument(by id: String) {
        service.request(DocumentsApi.publishDocument(id: id), model: String.self) { [weak self] model, error in
            if let error = error {
                print(error)
            }
            
            if let _ = model {
                self?.output?.documentPublished()
            }
        }
    }
}
