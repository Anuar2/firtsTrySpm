//
//  CreateDocFlowInteractorOutput.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol CreateDocFlowInteractorOutput: AnyObject {
    func sendCreateDocumentResponse(_ document: Document)
}
