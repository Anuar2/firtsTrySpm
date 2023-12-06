//
//  FilterFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation
import UIKit

protocol FilterFactory {
    func makeFilterView() -> FilterViewController
}

extension ModulesFactory: FilterFactory {
    func makeFilterView() -> FilterViewController {
        FilterModuleConfigurator().build(factory: self)
    }
}
