//
//  PDFFileModuleConfigurator.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

public final class PDFFileModuleConfigurator {

    func build(with data: Data?, factory: ModulesFactory) -> UIViewController {
        let router = PDFFileRouter(factory: factory)
        let viewController = PDFFileViewController()
        let presenter = PDFFilePresenter()
        viewController.pdfData = data
        presenter.view = viewController
        presenter.router = router

        let interactor = PDFFileInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        
        router.showPDFFileView()
        return viewController
    }

}
