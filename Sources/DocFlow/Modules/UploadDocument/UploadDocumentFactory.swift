//
//  UploadDocumentFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol UploadDocumentFactory {
    func makeUploadDocumentView() -> UIViewController
}

extension ModulesFactory: UploadDocumentFactory {
    func makeUploadDocumentView() -> UIViewController {
        UploadDocumentModuleConfigurator().build(factory: self)
    }
}
