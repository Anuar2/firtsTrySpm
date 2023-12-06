//
//  File.swift
//  
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol FilterInitiatorFactory {
    func makeFilterInitiatorView() -> FilterInitiatorViewController
}

extension ModulesFactory: FilterInitiatorFactory {
    func makeFilterInitiatorView() -> FilterInitiatorViewController {
        FilterInitiatorModuleConfigurator().build(factory: self)
    }
}
