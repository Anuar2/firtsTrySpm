//
//  LastModifiedFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol LastModifiedFactory {
    func makeLastModifiedView() -> LastModifiedViewController
}

extension ModulesFactory: LastModifiedFactory {
    func makeLastModifiedView() -> LastModifiedViewController {
        LastModifiedConfigurator().build(factory: self)
    }
}
