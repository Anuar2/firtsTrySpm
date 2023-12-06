//
//  AdDocumentInteractorOutput.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

protocol AdDocumentInteractorOutput: AnyObject {
    func documentIsLoaded(_ model: DocumentTemp)
    func attachmentIsLoaded(_ model: AttachmentModel)
}
