//
//  ErrorModel.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

struct ErrorModel: Error, Codable {
    let сode: String?
    let description: String?
    let origin: String?
    let timestamp: String?
}
