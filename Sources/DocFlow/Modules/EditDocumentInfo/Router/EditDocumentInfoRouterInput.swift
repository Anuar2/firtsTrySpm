//
//  EditDocumentInfoRouterInput.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol EditDocumentInfoRouterInput {
    func showInitiatorsView()
    func dissmiss()
    func presentPopUp() -> UIViewController
    func presentPopUpEmptyInitiator() -> UIViewController
    func presentPopUpFull() -> UIViewController
}
