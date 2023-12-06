//
//  PDFFileFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import Swinject


protocol PDFFileFactory {
    func makePDFFileView(with data: Data?) -> UIViewController
}

extension ModulesFactory: PDFFileFactory {
    func makePDFFileView(with data: Data?) -> UIViewController {
        PDFFileModuleConfigurator().build(with: data, factory: self)
    }
}
