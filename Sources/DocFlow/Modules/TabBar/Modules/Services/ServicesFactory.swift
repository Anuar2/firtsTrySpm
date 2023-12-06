//
//  ServicesFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol ServicesFactory {
    func makeServicesView() -> UIViewController
}

extension ModulesFactory: ServicesFactory {
    func makeServicesView() -> UIViewController {
        ServicesModuleConfigurator().build(factory: self)
    }
}
