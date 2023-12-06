//
//  StartDateCalendarViewPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class StartDateCalendarViewPresenter: StartDateCalendarViewModuleInput, StartDateCalendarViewViewOutput, StartDateCalendarViewInteractorOutput {

    weak var view: StartDateCalendarViewViewInput?
    var interactor: StartDateCalendarViewInteractorInput?
    var router: StartDateCalendarViewRouterInput?

    func viewIsReady() {

    }
    
    func dismiss() {
        router?.dismiss()
    }
}
