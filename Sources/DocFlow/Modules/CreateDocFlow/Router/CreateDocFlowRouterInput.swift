//
//  CreateDocFlowRouterInput.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol CreateDocFlowRouterInput {
    func presentDocFlowView()
    func presentSignatoriesView()
    func presentStartDateCalendarView()
    func presentEndDateCalendarView()
    func presentPopUp() -> UIViewController
    func showEditDocView(with data: Data?, viewmodel: DocumentViewModel?, documentURL: URL?)
    func dissmiss()
}
