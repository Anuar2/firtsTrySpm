//
//  DocumentActionsRouterInput.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol DocumentActionsRouterInput {
    func dissmiss()
    func presentEditDocumentAlert() -> UIViewController
    func showDownloadShareAlert(for fileURL: URL)
    func showEditAdDocumentInfoView(id: String?)
    func presentDeleteDocumentAlert(document: DocumentViewModel) -> UIViewController
}
