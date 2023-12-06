//
//  EditDocumentInfoInteractor.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

class EditDocumentInfoInteractor: EditDocumentInfoInteractorInput {
    weak var output: EditDocumentInfoInteractorOutput?
    private let service = NetworkManager()
    
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
