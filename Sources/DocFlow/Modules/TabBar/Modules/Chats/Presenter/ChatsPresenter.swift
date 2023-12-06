//
//  ChatsPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class ChatsPresenter: ChatsModuleInput, ChatsViewOutput, ChatsInteractorOutput {

    weak var view: ChatsViewInput!
    var interactor: ChatsInteractorInput!
    var router: ChatsRouterInput!

    func viewIsReady() {

    }
}
