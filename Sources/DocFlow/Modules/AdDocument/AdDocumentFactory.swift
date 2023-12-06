//
//  AdDocumentFactory.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol AdDocumentFactory {
    func makeAdDocumentView(id: String?) -> AdDocumentViewController
}

extension ModulesFactory: AdDocumentFactory {
    func makeAdDocumentView(id: String?) -> AdDocumentViewController {
        AdDocumentModuleConfigurator().build(factory: self, id: id)
    }
}
