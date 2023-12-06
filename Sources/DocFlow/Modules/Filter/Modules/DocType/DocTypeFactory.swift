//
//  DocTypeFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol DocTypeFactory {
    func makeDocTypeView() -> DocTypeViewController
}

extension ModulesFactory: DocTypeFactory {
    func makeDocTypeView() -> DocTypeViewController {
        DocTypeModuleConfigurator().build(factory: self)
    }
}
