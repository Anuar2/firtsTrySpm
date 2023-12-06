//
//  EditDocumentInfoPresenter.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

class EditDocumentInfoPresenter: EditDocumentInfoPresenterInputProtocol {
    weak var output: EditDocumentInfoPresenterOutputProtocol?
    var viewmodel: DocumentViewModel?

    var interactor: EditDocumentInfoInteractorInput?
    var router: EditDocumentInfoRouterInput?

    func viewIsReady() {
        interactor?.output = self
        guard let viewmodel = viewmodel else { return }
        output?.presentViewModel(viewmodel)
    }
    
    func dissmiss() {
        router?.dissmiss()
    }
    
    func presentInitiatorView() {
        router?.showInitiatorsView()
    }
    
    func presentPopUp() -> UIViewController {
        return router?.presentPopUp() ?? UIViewController()
    }
    
    func presentPopUpEmptyInitiator() -> UIViewController {
        return router?.presentPopUpEmptyInitiator() ?? UIViewController()
    }
    
    func presentPopUpFull() -> UIViewController {
        return router?.presentPopUpFull() ?? UIViewController()
    }
    
    func userDidTappedOnPublish() {
        guard let viewmodel = viewmodel else { return }
        interactor?.publishDocument(by: viewmodel.id)
    }
    
//    MARK: - Methods
    
}

// MARK: - Interactor
extension EditDocumentInfoPresenter: EditDocumentInfoInteractorOutput {
    func documentPublished() {
        DispatchQueue.main.async {
            self.output?.presentPublishResult(true)
        }
    }
}
