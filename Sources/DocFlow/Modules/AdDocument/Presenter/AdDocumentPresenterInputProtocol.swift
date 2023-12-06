//
//  AdDocumentPresenterInputProtocol.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

protocol AdDocumentPresenterInputProtocol {
    var output: AdDocumentPresenterOutputProtocol? {get set}
    
    func viewIsReady()
    func dissmiss()
    func documentActions(documentViewModel: DocumentViewModel)
    func getAttchment(id: String)
    func showEditAdDocumentInfoView()
}

protocol AdDocumentPresenterOutputProtocol {
    func presentViewModel(_ viewmodel: DocumentViewModel)
    func presentAttachmentLink(link: String)
}
