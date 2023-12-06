//
//  AdDocumentRouterInput.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol AdDocumentRouterInput {
    func dissmiss()
    func showEditAdDocumentInfoView(id: String?)
    func presentDocumentActions(documentViewModel: DocumentViewModel) -> UIViewController
}
