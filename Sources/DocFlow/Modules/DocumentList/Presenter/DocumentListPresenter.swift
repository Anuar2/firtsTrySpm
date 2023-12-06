//
//  DocumentListPresenter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol DocumentListPresenterInputProtocol: AnyObject {
    var output: DocumentListPresenterOutputProtocol? { get set }
    
    func getEmployes(q: String)
    func userDidSelectPDFFIle(with data: Data?)
    func userDidSelectFile() -> UIViewController
    func requestDocuments(q: FilterDocumentListModel)
    func requestInitialDocuments()
    func userDidClosePDF()
    func filterButtonDidTap()
    func searchButtonDidTap()
    func presentCreateDocFlow(with data: Data?, documentURL: URL?)
    func userChangedTab(to tab: String)
    func showAdDocumentView(with id: String?)
    func dissmiss()
}

protocol DocumentListPresenterOutputProtocol: AnyObject {
    func documents(_ viewmodel: DocumentsViewModel)
}

final class DocumentListPresenter {
    
    // MARK: - Properties
    
    var interactor: DocumentListInteractorInputProtocol
    var router: DocumentListRouterProtcol
    weak var output: DocumentListPresenterOutputProtocol?
    
    private var viewmodel: DocumentsViewModel?
    private var tab: String?
    private var emptyDocumentsViewModel: EmptyTableViewModel? = EmptyTableViewModel(image: "", title: "title", subtitle: "subtitle")
    
    //MARK: - Init
    
    init(
        interactor: DocumentListInteractorInputProtocol,
        router: DocumentListRouterProtcol
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    // TODO: - Временный метод
    private func filterDocuments() {
        guard let viewmodel = viewmodel else { return }
        switch tab {
        case DocumentTab.inbox.rawValue:
            // TODO: - Убрать
            output?.documents(viewmodel
                .filter { $0.status == "On signing" }
            )
        case DocumentTab.sent.rawValue:
            // TODO: - Убрать
            output?.documents(viewmodel
                .filter { $0.status == "On signing" }
            )
        case DocumentTab.draft.rawValue:
            // TODO: - Убрать
            output?.documents(viewmodel
                .filter { $0.status == "Draft" }
            )
        case DocumentTab.all.rawValue:
            output?.documents(viewmodel)
        default:
            output?.documents(viewmodel)
        }
    }
}

extension DocumentListPresenter: DocumentListPresenterInputProtocol {
    func getEmployes(q: String) {
        interactor.getEmployes(q: q)
    }
    
    func dissmiss() {
        router.dissmiss()
    }
    
    func presentCreateDocFlow(with data: Data?, documentURL: URL?) {
        router.showCreateDocFlow(with: data, documentURL: documentURL)
    }
    
    func userDidSelectPDFFIle(with data: Data?) {
        router.showPDFView(with: data)
    }
    
    func requestInitialDocuments() {
        interactor.output = self
        interactor.getInitialDocuments()
    }
    
    func requestDocuments(q: FilterDocumentListModel) {
        interactor.output = self
        interactor.getDocuments(q: q)
    }
    
    func userDidSelectFile() -> UIViewController {
        return router.presentDocumentPicker()
    }
    
    func userDidClosePDF() {
        
    }
    
    func filterButtonDidTap() {
        router.presentFilterView()
    }
    
    func searchButtonDidTap() {
        router.presentSearchView()
    }
    
    func userChangedTab(to tab: String) {
        self.tab = tab
        filterDocuments()
    }
    
    func showAdDocumentView(with id: String?) {
        router.showAdDocumentView(with: id)
    }
}

extension DocumentListPresenter: DocumentListInteractorOutputProtocol {
    func sendDocuments(_ model: Documents) {
        var viewmodel = DocumentsViewModel()
        model.forEach { document in
            viewmodel.append(document.toViewModel(with: "dd.MM.yyyy"))
        }
        
        self.viewmodel = viewmodel
        DispatchQueue.main.async {
            self.filterDocuments()
        }
    }
}

