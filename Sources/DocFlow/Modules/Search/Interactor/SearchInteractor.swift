//
//  File.swift
//  
//
//  Created by User on 05.12.2023.
//

import Foundation

class SearchInteractor: SearchInteractorInput {
    weak var output: SearchInteractorOutput?
    
    private let service = NetworkManager()
    
    func loadDocuments(q: FilterDocumentListModel) {
        if let jsonParameters = q.encode() {
            let apiParameters: Parameters = ["q": jsonParameters]

            service.request(DocumentsApi.getDocuments(parameters: apiParameters), model: DocumentsDTO.self) { [weak self] model, error in
                guard let self = self else { return }

                if let error = error {
                    print(error)
                }

                if let model = model {
                    self.output?.documentsLoaded(model.items)
                }
            }
        } else {
            print("Error encoding parameters")
        }
    }
}
