//
//  DocTypePresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class DocTypePresenter: DocTypeModuleInput, DocTypeViewOutput, DocTypeInteractorOutput {

    weak var view: DocTypeViewInput!
    var interactor: DocTypeInteractorInput!
    var router: DocTypeRouterInput!

    func viewIsReady() {

    }
    
    func dismiss() {
        router.dismiss()
    }
}
