//
//  RevokeDocumentAlertInteractor.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class RevokeDocumentAlertInteractor: RevokeDocumentAlertInteractorInput {
    
    weak var output: RevokeDocumentAlertInteractorOutput!

    private let service = NetworkManager()
    
    func deleteDocument(id: String) {
        service.request(DocumentsApi.revokeDocument(id: id), model: RevokeDocumentModel.self) { [weak self] model, error in
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
