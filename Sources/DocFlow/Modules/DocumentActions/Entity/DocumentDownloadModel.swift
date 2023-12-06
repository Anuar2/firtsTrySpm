//
//  DocumentDownloadModel.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

// MARK: - DocumentDownloadModel
struct DocumentDownloadModel: Codable {
    let id, bucketID, contentType, link: String?
    let size: Int?
    let documentDownloadModelExtension, name, creatorID, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bucketID = "bucketId"
        case contentType, link, size
        case documentDownloadModelExtension = "extension"
        case name
        case creatorID = "creatorId"
        case createdAt, updatedAt
    }
}
