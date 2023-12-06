//
//  AttachmentModel.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

// MARK: - AttachmentModel
public struct AttachmentModel: Codable {
    let id: String?
    var bucketID, contentType, link: String?
    var size: Int?
    var attachmentsModelExtension, name, creatorID, createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bucketID = "bucketId"
        case contentType, link, size
        case attachmentsModelExtension = "extension"
        case name
        case creatorID = "creatorId"
        case createdAt, updatedAt
    }
    
    func encode() -> [String: Any?] {
        return ["id": id,
                "bucketId": bucketID,
                "contentType": contentType,
                "link": link,
                "size": size,
                "extension": attachmentsModelExtension,
                "name": name,
                "creatorId": creatorID,
                "createdAt": createdAt,
                "updatedAt": updatedAt]
    }
}
