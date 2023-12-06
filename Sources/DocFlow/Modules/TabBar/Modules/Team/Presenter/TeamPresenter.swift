//
//  TeamPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class TeamPresenter: TeamModuleInput, TeamViewOutput, TeamInteractorOutput {

    weak var view: TeamViewInput!
    var interactor: TeamInteractorInput!
    var router: TeamRouterInput!

    func viewIsReady() {

    }
}
