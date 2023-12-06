//
//  CreationDateFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol CreationDateFactory {
    func makeCreationDateView() -> CreationDateViewController
}

extension ModulesFactory: CreationDateFactory {
    func makeCreationDateView() -> CreationDateViewController {
        CreationDateModuleConfigurator().build(factory: self)
    }
}
