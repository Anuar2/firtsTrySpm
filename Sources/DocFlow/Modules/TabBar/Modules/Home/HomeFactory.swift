//
// HomeFactory.swift
//  
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol HomeFactory {
    func makeHomeView() -> UIViewController
}

extension ModulesFactory: HomeFactory {
    func makeHomeView() -> UIViewController {
        HomeModuleConfigurator().build(factory: self)
    }
}
