//
//  DeleteDocumentAlertFactory.swift
//  
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol DeleteDocumentAlertFactory {
    func makeDeleteDocumentAlertView(id: String) -> DeleteDocumentAlertViewController
}

extension ModulesFactory: DeleteDocumentAlertFactory {
    func makeDeleteDocumentAlertView(id: String) -> DeleteDocumentAlertViewController {
        DeleteDocumentAlertModuleConfigurator().build(factory: self, id: id)
    }
}
