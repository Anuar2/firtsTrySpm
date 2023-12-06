//
//  FilterPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

protocol FilterPresenterInputProtocol: AnyObject {
    var output: FilterPresenterProtocol? { get set }

    
    func viewIsReady()
    func dissmiss()
    func presentDocTypeView()
    func presentFilterInitiatorView()
    func presentCreationDateView()
    func presentExpireDateView()
    func presentLastModifitedView()
    func requestDocuments(q: FilterDocumentListModel)
}

protocol FilterPresenterProtocol: AnyObject {
    func presentViewModel(document: DocumentsViewModel)
}

final class FilterPresenter: FilterPresenterInputProtocol {
    
    // MARK: - Properties
    var interactor: FilterInteractorInput?
    var router: FilterRouterInput?
    weak var output: FilterPresenterProtocol?

    func viewIsReady() {

    }
    
    func presentDocTypeView() {
        router?.presentDocTypeView()
    }
    
    func presentFilterInitiatorView() {
        router?.presentFilterInitiatorView()
    }
    
    func presentCreationDateView() {
        router?.presentCreationDateView()
    }
    
    func presentExpireDateView() {
        router?.presentExpireDateView()
    }
    
    func requestDocuments(q: FilterDocumentListModel) {
        interactor?.output = self
        interactor?.requestDocument(q: q)
    }
    
    func presentLastModifitedView() {
        router?.presentLastModifitedView()
    }
    
    func dissmiss() {
        router?.dissmiss()
    }

}


extension FilterPresenter: FilterInteractorOutput {
    func docFilter(filterModel: Documents) {
        var viewmodel = DocumentsViewModel()
        filterModel.forEach {
            viewmodel.append($0.toViewModel(with: "dd.MM.yyyy"))
        }
        output?.presentViewModel(document: viewmodel)
    }
}
