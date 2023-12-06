//
//  File.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

struct DocumentViewModel {
    var id: String
    var attachmentID: String
    var type: String
    var title: String
    var description: String?
    var startDate: String?
    var endDate: String?
    var createdAt: String
    var updatedAt: String
    var status: String
    var number: String
    var initiatorFullname: String?
    var initiatorAvatar: String?
    var signatories: [FilterInitiatorModel]? = nil
    var documentLink: String?
}

typealias DocumentsViewModel = [DocumentViewModel]
