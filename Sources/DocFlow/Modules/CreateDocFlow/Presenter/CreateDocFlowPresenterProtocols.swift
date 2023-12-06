//
//  CreateDocFlowPresenterProtocols.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol CreateDocFlowPresenterInputProtocol: AnyObject {
    var output: CreateDocFlowPresenterOutputProtocol? { get set }
    var signatories: [String]? { get set }
    var docNumber: String? { get set }
    var docName: String? { get set }
    var docTypeText: String? { get set }
    var docDescription: String? { get set }
    var startDate: String? { get set }
    var endDate: String? { get set }
    
    func presentDocTypeView()
    func presentSignatoriesView()
    func presentStartDateCalendarView()
    func presentEndDateCalendarView()
    func presentPopUp() -> UIViewController
    func presentStartCalendar()
    func presentEndCalendarView()
    func dissmiss()
    func presentEditDocView(with data: Data?, viewmodel: DocumentViewModel, documentURL: URL?)
    
    func sendDocumentToCreate()
}

protocol CreateDocFlowPresenterOutputProtocol: AnyObject {
    func gotoPreview(_ document: DocumentViewModel)
    func validation(_ bool: Bool)
}
