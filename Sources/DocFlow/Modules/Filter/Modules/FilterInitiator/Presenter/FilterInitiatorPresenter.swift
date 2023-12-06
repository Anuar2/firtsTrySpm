//
//  FilterInitiatorPresenter.swift
//  
//
//  Created by User on 05.12.2023.
//

import Foundation

class FilterInitiatorPresenter: FilterInitiatorModuleInput, FilterInitiatorViewOutput, FilterInitiatorInteractorOutput {

    weak var view: FilterInitiatorViewInput!
    var interactor: FilterInitiatorInteractorInput!
    var router: FilterInitiatorRouterInput!

    func viewIsReady() {

    }
    
    func didSelectInitiator(_ selectedInitiators: [FilterInitiatorModel]) {
        interactor.didSelectInitiator(selectedInitiators)
    }
    
    func dismiss() {
        router.dissmiss()
    }
}
