//
//  FilterFilterInteractor.swift
//
//
//  Created by User on 05.12.2023.
//

protocol FilterInteractorInput: AnyObject {
    var output: FilterInteractorOutput? { get set }
    func requestDocument(q: FilterDocumentListModel)
}

protocol FilterInteractorOutput: AnyObject {
    func docFilter(filterModel: Documents)
}

final class FilterInteractor: FilterInteractorInput {

    weak var output: FilterInteractorOutput?
    private let service = NetworkManager()

    func requestDocument(q: FilterDocumentListModel) {
        if let jsonParameters = q.encode() {
            let apiParameters: Parameters = ["q": jsonParameters]

            service.request(DocumentsApi.getDocuments(parameters: apiParameters), model: DocumentsDTO.self) { [weak self] model, error in
                guard let self = self else { return }

                if let error = error {
                    print(error)
                }

                if let model = model {
                    self.output?.docFilter(filterModel: model.items)
                }
            }
        } else {
            print("Error encoding parameters")
        }
    }
}
