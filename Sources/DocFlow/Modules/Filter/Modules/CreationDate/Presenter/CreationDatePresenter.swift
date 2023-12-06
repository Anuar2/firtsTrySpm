//
//  CreationDatePresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class CreationDatePresenter: CreationDateModuleInput, CreationDateViewOutput, CreationDateInteractorOutput {

    weak var view: CreationDateViewInput!
    var interactor: CreationDateInteractorInput!
    var router: CreationDateRouterInput!

    func viewIsReady() {

    }
}
