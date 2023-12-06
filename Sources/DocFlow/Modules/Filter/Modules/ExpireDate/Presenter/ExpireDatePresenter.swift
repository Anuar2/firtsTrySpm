//
//  ExpireDatePresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

class ExpireDatePresenter: ExpireDateModuleInput, ExpireDateViewOutput, ExpireDateInteractorOutput {

    weak var view: ExpireDateViewInput!
    var interactor: ExpireDateInteractorInput!
    var router: ExpireDateRouterInput!

    func viewIsReady() {

    }
}
