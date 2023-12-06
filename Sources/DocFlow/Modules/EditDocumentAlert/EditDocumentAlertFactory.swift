//
//  EditDocumentAlertFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol EditDocumentAlertFactory {
    func makeEditDocumentAlertView() -> EditDocumentAlertViewController
}

extension ModulesFactory: EditDocumentAlertFactory {
    func makeEditDocumentAlertView() -> EditDocumentAlertViewController {
        EditDocumentAlertModuleConfigurator().build(factory: self)
    }
}
