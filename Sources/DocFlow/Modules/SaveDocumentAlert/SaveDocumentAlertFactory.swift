//
//  SaveDocumentAlertFactory.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol SaveDocumentAlertFactory {
    func makeSaveDocumentAlertView() -> UIViewController
}

extension ModulesFactory: SaveDocumentAlertFactory {
    func makeSaveDocumentAlertView() -> UIViewController {
        SaveDocumentAlertModuleConfigurator().build(factory: self)
    }
}
