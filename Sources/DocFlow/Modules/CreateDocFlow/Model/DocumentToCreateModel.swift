//
//  DocumentToCreateModel.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

struct DocumentToCreateModel: Codable {
    let attachmentID: String
    let type: Int
    let title: String
    let signingType: String
    let signatories: [String]
    let number: String
    let startDate, expiryDate: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case attachmentID = "attachmentId"
        case type, title, signingType, signatories, number, startDate, expiryDate, description
    }
    
    func encode() -> [String: Any?] {
        return ["attachmentId": attachmentID,
                "type": type,
                "title": title,
                "number": number,
                "signingType": signingType,
                "signatories": signatories,
                "startDate": startDate,
                "expiryDate": expiryDate,
                "description": description]
    }
    
    struct CreateDocumentResponse: Decodable {
        var message: String
        
        enum CodingKeys: String, CodingKey {
            case message
        }
    }
}
