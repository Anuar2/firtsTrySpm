//
//  GetDocAttachment.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

// MARK: - GetDocAttachment
struct GetDocAttachment: Decodable {
    let bucketID: String
    
    func encode() -> [String: Any?] {
        return ["bucketId": bucketID]
               
    }
}
