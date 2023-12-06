//
//  MyWorkFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol MyWorkFactory {
    func makeMyWorkView() -> UIViewController
}

extension ModulesFactory: MyWorkFactory {
    func makeMyWorkView() -> UIViewController {
        MyWorkModuleConfigurator().build(factory: self)
    }
}
