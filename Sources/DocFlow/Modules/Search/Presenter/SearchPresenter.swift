//
//  SearchPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class SearchPresenter: SearchPresenterInput {

    weak var output: SearchPresenterOutput?
    var interactor: SearchInteractorInput
    var router: SearchRouterInput
    
    private var tab: String?
    private var viewmodel: DocumentsViewModel?
    
    init(interactor: SearchInteractorInput,
         router: SearchRouterInput) {
        
        self.interactor = interactor
        self.router = router
    }
    
    func viewIsReady() {
        interactor.output = self
    }
    
    func userChangedTab(to tab: String) {
        self.tab = tab.uppercased()
        var filterDocument: FilterDocumentListModel = FilterDocumentListModel(statuses: [self.tab ?? ""], page: 1, size: 25)
        interactor.loadDocuments(q: filterDocument)
    }
    
    func dissmiss() {
        router.dissmiss()
    }
    
    func filterDocumentsBy(_ title: String) {
        guard let viewmodel = viewmodel else { return }
        guard !title.isEmpty else {
            output?.presentResult(viewmodel)
            return
        }
        output?.presentResult(viewmodel
            .filter { $0.title.contains(title) }
        )
    }
}

// MARK: - Interactor
extension SearchPresenter: SearchInteractorOutput {
    func documentsLoaded(_ model: Documents) {
        var viewmodel = DocumentsViewModel()
        model.forEach { document in
            viewmodel.append(document.toViewModel(with: "dd.MM.yyyy"))
        }
        
        self.viewmodel = viewmodel
        DispatchQueue.main.async {
            self.output?.presentResult(viewmodel)
        }
    }
}
