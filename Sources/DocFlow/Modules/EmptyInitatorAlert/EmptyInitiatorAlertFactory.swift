//
//  EmptyInitiatorAlertFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol EmptyInitiatorAlertFactory {
    func makeEmptyInitiatorAlertView() -> UIViewController
}

extension ModulesFactory: EmptyInitiatorAlertFactory {
    func makeEmptyInitiatorAlertView() -> UIViewController {
        EmptyInitiatorAlertModuleConfigurator().build(factory: self)
    }
}
