//
//  EditAdDocumentInfoFactory.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol EditAdDocumentInfoFactory {
    func makeEditAdDocumentInfoView(id: String?) -> EditAdDocumentInfoViewController
}

extension ModulesFactory: EditAdDocumentInfoFactory {
    func makeEditAdDocumentInfoView(id: String?) -> EditAdDocumentInfoViewController {
        EditAdDocumentInfoInfoModuleConfigurator().build(factory: self, id: id)
    }
}
