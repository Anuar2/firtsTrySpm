//
//  MyWorkPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class MyWorkPresenter: MyWorkModuleInput, MyWorkViewOutput, MyWorkInteractorOutput {

    weak var view: MyWorkViewInput!
    var interactor: MyWorkInteractorInput!
    var router: MyWorkRouterInput!

    func viewIsReady() {

    }
}
