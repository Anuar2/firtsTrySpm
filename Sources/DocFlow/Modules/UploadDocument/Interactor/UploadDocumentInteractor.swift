//
//  UploadDocumentInteractor.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class UploadDocumentInteractor: UploadDocumentInteractorInput {

    weak var output: UploadDocumentInteractorOutput?
    private let service = NetworkManager()
    
    func uploadDocument(with data: Data?) {
        guard let data = data else { return }
        
        service.request(DocumentsApi.uploadDocument(parameters: data), model: UploadDocument.self) { [weak self] model, error in
            if let error = error {
                print(error)
            }
            
            if let model = model {
                self?.output?.sendUploadDocument(model)
            }
        }
    }
}
