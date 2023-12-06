//
//  RevokeDocumentAlertFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol RevokeDocumentAlertFactory {
    func makeRevokeDocumentAlertView(id: String) -> RevokeDocumentAlertViewController
}

extension ModulesFactory: RevokeDocumentAlertFactory {
    func makeRevokeDocumentAlertView(id: String) -> RevokeDocumentAlertViewController {
        RevokeDocumentAlertModuleConfigurator().build(factory: self, id: id)
    }
}
