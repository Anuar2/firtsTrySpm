//
//  EditAdDocumentInfoRouterInput.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol EditAdDocumentInfoRouterInput {
    func dissmiss()
    func presentPopUp() -> UIViewController
    func presentPopUpFull() -> UIViewController
    func presentPopUpEmptyInitiator() -> UIViewController
    func showDocumentPicker()
    func showInitiatorsView()
    func showStartDateView()
    func showEndDateView()
}
