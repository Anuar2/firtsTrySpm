//
//  CreateDocFlowFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol CreateDocFlowFactory {
    func makeCreateDocFlow(with data: Data?, documentURL: URL?) -> UIViewController
}

extension ModulesFactory: CreateDocFlowFactory {
    func makeCreateDocFlow(with data: Data?, documentURL: URL?) -> UIViewController {
        CreateDocFlowConfigurator().build(factory: self, with: data, documentURL: documentURL)
    }
}
