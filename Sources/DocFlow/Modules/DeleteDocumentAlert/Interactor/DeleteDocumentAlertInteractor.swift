//
//  DeleteDocumentAlertInteractor.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class DeleteDocumentAlertInteractor: DeleteDocumentAlertInteractorInput {
    
    weak var output: DeleteDocumentAlertInteractorOutput!

    private let service = NetworkManager()
    
    func deleteDocument(id: String) {
        service.request(DocumentsApi.deleteDocument(id: id), model: DeleteDocumentModel.self) { [weak self] model, error in
            guard let self = self else { return }
            
            if let error = error {
                print(error)
            }
            
            if let model = model {
                print(model)
            }
        }
    }

}
