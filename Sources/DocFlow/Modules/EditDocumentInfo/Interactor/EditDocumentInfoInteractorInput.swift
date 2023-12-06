//
//  EditDocumentInfoInteractorInput.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

protocol EditDocumentInfoInteractorInput {
    var output: EditDocumentInfoInteractorOutput? { get set }
    
    func publishDocument(by id: String)
}
