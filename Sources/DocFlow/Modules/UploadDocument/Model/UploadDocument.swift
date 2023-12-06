//
//  UploadDocument.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

// MARK: - UploadDocument
struct UploadDocument: Codable {
    let id, bucketID, contentType, link: String
    let size: Int
    let uploadDocumentExtension, name, creatorID, createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case bucketID = "bucketId"
        case contentType, link, size
        case uploadDocumentExtension = "extension"
        case name
        case creatorID = "creatorId"
        case createdAt, updatedAt
    }
}
