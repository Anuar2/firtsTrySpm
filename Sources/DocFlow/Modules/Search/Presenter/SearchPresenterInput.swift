//
//  SearchPresenterInput.swift
//
//
//  Created by User on 05.12.2023.
//

protocol SearchPresenterInput {

    /**
        @author Anuar
        Notify presenter that view is ready
    */
    var output: SearchPresenterOutput? { get set }

    func viewIsReady()
    func userChangedTab(to tab: String)
    func filterDocumentsBy(_ title: String)
    func dissmiss()
}
