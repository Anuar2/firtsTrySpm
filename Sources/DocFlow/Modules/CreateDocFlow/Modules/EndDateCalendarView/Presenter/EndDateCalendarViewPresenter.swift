//
//  EndDateCalendarViewPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class EndDateCalendarViewPresenter: EndDateCalendarViewModuleInput, EndDateCalendarViewViewOutput, EndDateCalendarViewInteractorOutput {

    weak var view: EndDateCalendarViewViewInput!
    var interactor: EndDateCalendarViewInteractorInput!
    var router: EndDateCalendarViewRouterInput!

    func viewIsReady() {

    }
    
    func dissmiss() {
        router.dissmiss()
    }
}
