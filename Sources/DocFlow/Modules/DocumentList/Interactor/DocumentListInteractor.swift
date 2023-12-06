//
//  DocumentListInteractor.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol DocumentListInteractorInputProtocol: AnyObject {
    var output: DocumentListInteractorOutputProtocol? { get set }
    
    func getEmployes(q: String)
    func getDocuments(q: FilterDocumentListModel)
    func getInitialDocuments()
}

protocol DocumentListInteractorOutputProtocol: AnyObject {
    func sendDocuments(_ model: Documents)
}

final class DocumentListInteractor: DocumentListInteractorInputProtocol {
    weak var output: DocumentListInteractorOutputProtocol?
    private let service = NetworkManager()

    
    func getEmployes(q: String) {
//        let apiParameters: Parameters = [""]
//
//        service.request(DocumentsApi.getCompanyEmployees(model: apiParameters), model: EmployeeModel.self) { [weak self] model, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                print(error)
//            }
//
//            if let model = model {
//                print(model)
//            }
//        }
    }
    
    func getDocuments(q: FilterDocumentListModel) {
        if let jsonParameters = q.encode() {
            let apiParameters: Parameters = ["q": jsonParameters]

            service.request(DocumentsApi.getDocuments(parameters: apiParameters), model: DocumentsDTO.self) { [weak self] model, error in
                guard let self = self else { return }

                if let error = error {
                    print(error)
                }

                if let model = model {
                    self.output?.sendDocuments(model.items)
                }
            }
        }
    }
    
    func getInitialDocuments() {
        service.request(DocumentsApi.getInitialDocuments, model: DocumentsDTO.self) { [weak self] model, error in
            guard let self = self else { return }

            if let error = error {
                print(error)
            }

            if let model = model {
                self.output?.sendDocuments(model.items)
            }
        }
    }
}

