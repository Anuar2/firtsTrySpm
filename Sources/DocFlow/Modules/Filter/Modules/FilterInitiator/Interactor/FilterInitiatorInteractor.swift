//
//  FilterInitiatorInteractor.swift
//  
//
//  Created by User on 05.12.2023.
//

import Foundation

class FilterInitiatorInteractor: FilterInitiatorInteractorInput {
    var selectedInitiators: [FilterInitiatorModel] = []

    weak var output: FilterInitiatorInteractorOutput!
    
    func didSelectInitiator(_ selectedInitiators: [FilterInitiatorModel]) {
        self.selectedInitiators = selectedInitiators
    }
}
