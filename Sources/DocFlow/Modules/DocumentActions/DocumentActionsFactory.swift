//
//  DocumentActionsFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol DocumentActionsFactory {
    func makeDocumentActionsView(documentViewModel: DocumentViewModel) -> DocumentActionsViewController
}

extension ModulesFactory: DocumentActionsFactory {
    func makeDocumentActionsView(documentViewModel: DocumentViewModel) -> DocumentActionsViewController {
        DocumentActionsModuleConfigurator().build(factory: self, documentViewModel: documentViewModel)
    }
}
