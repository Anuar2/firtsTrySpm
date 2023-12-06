//
//  ExpireDateFactory.swift
//  
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol ExpireDateFactory {
    func makeExpireDateView() -> ExpireDateViewController
}

extension ModulesFactory: ExpireDateFactory {
    func makeExpireDateView() -> ExpireDateViewController {
        ExpireDateConfigurator().build(factory: self)
    }
}
