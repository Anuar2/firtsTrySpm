//
//  PDFFilePresenter.swift
//
//
//  Created by User on 05.12.2023.
//

class PDFFilePresenter: PDFFileModuleInput, PDFFileViewOutput, PDFFileInteractorOutput {

    weak var view: PDFFileViewInput?
    var interactor: PDFFileInteractorInput?
    var router: PDFFileRouterInput?

    func viewIsReady() {

    }
}
