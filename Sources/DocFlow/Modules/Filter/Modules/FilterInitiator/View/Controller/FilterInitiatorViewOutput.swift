//
//  FilterInitiatorViewOutput.swift
//
//
//  Created by User on 05.12.2023.
//

protocol FilterInitiatorViewOutput {

    /**
        @author Anuar
        Notify presenter that view is ready
    */

    func viewIsReady()
    func didSelectInitiator(_ selectedInitiators: [FilterInitiatorModel])
    func dismiss()

}
