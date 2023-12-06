//
//  EditDocumentInfoFactory.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol EditDocumentInfoFactory {
    func makeEditDocumentInfoView(with data: Data?, model: DocumentViewModel?, documentURL: URL?) -> UIViewController
}

extension ModulesFactory: EditDocumentInfoFactory {
    func makeEditDocumentInfoView(with data: Data?, model: DocumentViewModel?, documentURL: URL?) -> UIViewController {
        EditDocumentInfoModuleConfigurator().build(factory: self, data: data, model: model, documentURL: documentURL)
    }
}
