//
//  TabBarPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class TabBarPresenter: TabBarModuleInput, TabBarViewOutput, TabBarInteractorOutput {

    weak var view: TabBarViewInput?
    var interactor: TabBarInteractorInput?
    var router: TabBarRouterInput?

    func viewIsReady() {
        
    }
    
    private func setupControllers() {
        
    }
}
