//
//  ServicesPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class ServicesPresenter: ServicesModuleInput, ServicesViewOutput, ServicesInteractorOutput {
    
    weak var view: ServicesViewInput?
    var interactor: ServicesInteractorInput?
    var router: ServicesRouterInput?

    func viewIsReady() {

    }
    
    func showDocumentsButtonDidTap() {
        router?.showDocumentListView()
    }
    
    func prepareDocTypes() {
        
    }
}
