//
//  SearchFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol SearchFactory {
    func makeSearchView() -> UIViewController
}

extension ModulesFactory: SearchFactory {
    func makeSearchView() -> UIViewController {
        SearchModuleConfigurator().build(factory: self)
    }
}
