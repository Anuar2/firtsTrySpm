//
//  AdDocumentInteractorInput.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

protocol AdDocumentInteractorInput {
    var output: AdDocumentInteractorOutput? { get set }
    
    func requestDocument(by id: String)
    func requestAttachment(by id: String)
}
