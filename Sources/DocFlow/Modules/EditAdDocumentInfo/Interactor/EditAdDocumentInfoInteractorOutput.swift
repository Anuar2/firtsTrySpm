//
//  EditAdDocumentInfoInteractorOutput.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

protocol EditAdDocumentInfoInteractorOutput: class {
    func documentIsLoaded(_ model: DocumentTemp)
    func attachmentIsLoaded(_ model: AttachmentModel)
    func documentUpdated(_ model: DocumentViewModel)
    func documentPublished()
}
