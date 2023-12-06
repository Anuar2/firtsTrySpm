//
//  DocumentListFactory.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import Swinject


protocol DocumentListFactory {
    func makeDocumentList() -> UIViewController
}

extension ModulesFactory: DocumentListFactory {
    func makeDocumentList() -> UIViewController {
        DocumentListBuilder().build(factory: self)
    }
}
