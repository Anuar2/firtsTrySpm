//
//  DocumentActionsViewOutput.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol DocumentActionsViewOutput {

    /**
        @author Anuar
        Notify presenter that view is ready
    */

    func viewIsReady()
    func dissmiss()
    func presentEditDociment()
    func downloadDocument(document: DocumentViewModel)
    func deleteDocument(document: DocumentViewModel)
    func showEditAdDocumentInfoView(id: String?)
}
