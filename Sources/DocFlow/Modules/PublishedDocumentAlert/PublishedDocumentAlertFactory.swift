//
//  PublishedDocumentAlertFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol PublishedDocumentAlertFactory {
    func makePublishedDocumentAlertView() -> UIViewController
}

extension ModulesFactory: PublishedDocumentAlertFactory {
    func makePublishedDocumentAlertView() -> UIViewController {
        PublishedDocumentAlertModuleConfigurator().build(factory: self)
    }
}
