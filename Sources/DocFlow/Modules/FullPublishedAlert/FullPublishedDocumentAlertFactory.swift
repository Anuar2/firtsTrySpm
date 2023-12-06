//
//  FullPublishedDocumentAlertFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol FullPublishedDocumentAlertFactory {
    func makeFullPublishedDocumentAlertView() -> UIViewController
}

extension ModulesFactory: FullPublishedDocumentAlertFactory {
    func makeFullPublishedDocumentAlertView() -> UIViewController {
        FullPublishedDocumentAlertModuleConfigurator().build(factory: self)
    }
}
