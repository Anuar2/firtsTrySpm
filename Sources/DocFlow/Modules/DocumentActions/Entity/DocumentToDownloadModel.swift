//
//  DocumentToDownloadModel.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

// MARK: - DocumentToDownloadModel
struct DocumentToDownloadModel: Codable {
    let file: String?
    
    func encode() -> [String: Any?] {
        return ["file": file]
    }
}
