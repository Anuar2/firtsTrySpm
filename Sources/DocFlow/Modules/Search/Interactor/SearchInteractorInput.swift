//
//  SearchInteractorInput.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol SearchInteractorInput {
    var output: SearchInteractorOutput? { get set }
    
    func loadDocuments(q: FilterDocumentListModel)
}
