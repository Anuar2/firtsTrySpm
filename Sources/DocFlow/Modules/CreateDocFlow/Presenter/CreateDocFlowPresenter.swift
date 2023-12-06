//
//  CreateDocFlowPresenter.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class CreateDocFlowPresenter: CreateDocFlowPresenterInputProtocol {

    weak var output: CreateDocFlowPresenterOutputProtocol?
    var interactor: CreateDocFlowInteractorInput!
    var router: CreateDocFlowRouterInput!
    var viewModel: DocumentViewModel?
    
    func presentDocTypeView() {
        router?.presentDocFlowView()
    }
    
    func presentSignatoriesView() {
        router?.presentSignatoriesView()
    }
    
    func presentStartDateCalendarView() {
        router?.presentStartDateCalendarView()
    }
    
    func presentEndDateCalendarView() {
        router?.presentEndDateCalendarView()
    }
    
    func presentPopUp() -> UIViewController {
        return router?.presentPopUp() ?? UIViewController()
    }
    
    func presentEditDocView(with data: Data?, viewmodel: DocumentViewModel, documentURL: URL?) {
        router.showEditDocView(with: data, viewmodel: viewmodel, documentURL: documentURL)
    }
    
    func dissmiss() {
        router?.dissmiss()
    }
    
    func presentStartCalendar() {
        router.presentStartDateCalendarView()
    }
    
    func presentEndCalendarView() {
        router.presentEndDateCalendarView()
    }
    
    func sendDocumentToCreate() {
        guard let document = generateModel() else { return }
        interactor.createDocument(document)
    }
    
//    MARK: - Properties
    var signatories: [String]? {
        didSet {
            validateInputFields()
        }
    }
    var docNumber: String? {
        didSet {
            validateInputFields()
        }
    }
    var docName: String? {
        didSet {
            validateInputFields()
        }
    }
    var docTypeText: String? {
        didSet {
            validateInputFields()
        }
    }
    private let signingType: String = "DIGITAL"
    var docDescription: String? {
        didSet {
            validateInputFields()
        }
    }
    var startDate: String? {
        didSet {
            validateInputFields()
        }
    }
    var endDate: String? {
        didSet {
            validateInputFields()
        }
    }
    
    
//    MARK: - Methods
    private func documentPeriodAdapter(_ date: String?) -> String {
        guard let date = date else { return String() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: date) else { return String() }
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    private func validateInputFields() {
        let isDocNumberValid = !(docNumber?.isEmpty ?? true)
        let isDocNameValid = !(docName?.isEmpty ?? true)
        let isDescriptionValid = !(docDescription?.isEmpty ?? true)
        let isStartDateValid = !(startDate?.isEmpty ?? true)
        let isEndDateValid = !(endDate?.isEmpty ?? true)

        let isInputValid = isDocNumberValid && isDocNameValid && isDescriptionValid && isStartDateValid && isEndDateValid
        output?.validation(isInputValid)
    }
    
    private func generateModel() -> DocumentToCreateModel? {
        // TODO: - Убрать хардкод
        guard let title = docName,
              let signatories = signatories,
              let number = docNumber else { return nil }
        let attachmentID = "7d90867c-985d-4db7-884d-e629e9eb7cd1"
        let type = 1
        
        return DocumentToCreateModel(
            attachmentID: attachmentID,
            type: type,
            title: title,
            signingType: signingType,
            signatories: signatories,
            number: number,
            startDate: createDocumentAdapter(startDate),
            expiryDate: createDocumentAdapter(endDate),
            description: docDescription
        )
    }
    
    private func createDocumentAdapter(_ date: String?) -> String {
        guard let date = date else { return String() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        guard let date = dateFormatter.date(from: date) else { return String() }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

extension CreateDocFlowPresenter: CreateDocFlowInteractorOutput {
    func sendCreateDocumentResponse(_ document: Document) {
        let viewmodel = document.toViewModel(with: "MMM d, yyyy")
        
        DispatchQueue.main.async {
            self.output?.gotoPreview(viewmodel)
        }
    }
}

