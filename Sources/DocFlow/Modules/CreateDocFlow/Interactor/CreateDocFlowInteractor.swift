//
//  CreateDocFlowInteractor.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class CreateDocFlowInteractor: CreateDocFlowInteractorInput {

    weak var output: CreateDocFlowInteractorOutput?
    private let service = NetworkManager()
    
    func createDocument(_ document: DocumentToCreateModel) {
        service.request(DocumentsApi.createDocument(model: document.encode() as Parameters), model: Document.self) { [weak self] model, error in
            guard let self = self else { return }
            
            if let error = error {
                print(error)
            }
            if let model = model {
                print(model)
                self.output?.sendCreateDocumentResponse(model)
            }
        }
    }
}
