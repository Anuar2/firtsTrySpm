//
//  EditAdDocumentInfoInteractorInput.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

protocol EditAdDocumentInfoInteractorInput {
    var output: EditAdDocumentInfoInteractorOutput? { get set }
    
    func requestDocument(by id: String)
    func requestAttachment(by id: String)
    func updateDocument(_ id: String,_ document: DocumentToCreateModel)
    func publishDocument(by id: String)
}
