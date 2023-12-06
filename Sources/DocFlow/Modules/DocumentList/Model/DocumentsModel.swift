//
//  DocumentsModel.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

//MARK: - DocumentTab
enum DocumentTab: String {
    case all = "All"
    case inbox = "Inbox"
    case sent = "Sent"
    case draft = "Draft"
}

struct DocumentsDTO: Codable {
    let size, page, total: Int
    let items: Documents
}

// MARK: - Document
struct Document: Codable {
    let id, attachmentID: String?
    let type: Int?
    let title: String?
    let signingType: SigningType
    let signatories: [String]?
    let number: String?
    let startDate, expiryDate, description: String?
    let createdAt, updatedAt: String?
    let status: Status
    let initiator: Initiator

    enum CodingKeys: String, CodingKey {
        case id
        case attachmentID = "attachmentId"
        case type, title, signingType, signatories, number, startDate, expiryDate, description, createdAt, updatedAt, status, initiator
    }
    
    func getType() -> String {
        switch type {
        case 0: return "Contract"
        case 1: return "Agreement"
        case 2: return "Letter"
        default: return "Document"
        }
    }
    
    func getStatus() -> String {
        switch status {
        case .draft:
            return "Draft"
        case .signing:
            return "On signing"
        case .signed:
            return "Signed"
        }
    }
    
    func encode() -> [String: Any?] {
        return ["id": id,
                "attachmentId": attachmentID,
                "type": type,
                "title": title,
                "number": number,
                "signingType": signingType,
                "signatories": signatories,
                "startDate": startDate,
                "expiryDate": expiryDate,
                "description": description]
    }
    
    func toViewModel(with dateFormat: String?) -> DocumentViewModel {
        let initiatorAvatar = initiator.avatar ?? String()
        let initiatorFullname = "\(initiator.name ?? "") \(initiator.surname ?? "")"
        let startDate = documentPeriodAdapter(startDate, dateFormat)
        let expiryDate = documentPeriodAdapter(expiryDate, dateFormat)
        let createdAt = documentPeriodAdapter(createdAt, dateFormat)
        let updatedAt = documentPeriodAdapter(updatedAt, dateFormat)
        let type = getType()
        let status = getStatus()
    
        let documentVM = DocumentViewModel(id: id ?? "", attachmentID: attachmentID ?? "", type: type, title: title ?? "", description: description, startDate: startDate, endDate: expiryDate, createdAt: createdAt, updatedAt: updatedAt, status: status, number: number ?? "", initiatorFullname: initiatorFullname, initiatorAvatar: initiatorAvatar)
            return documentVM
    }
    
    private func documentPeriodAdapter(_ date: String?,_ dateFormat: String?) -> String {
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         
         if let dateString = date, dateString != "null",
            let date = dateFormatter.date(from: dateString),
                let dateFormat = dateFormat {
             dateFormatter.dateFormat = dateFormat
             return dateFormatter.string(from: date)
         } else {
             return "22.10.2023"
         }
    }
}

// MARK: - Initiator
struct Initiator: Codable {
    let id: String
    let name: String?
    let surname: String?
    let avatar: String?
}

enum SigningType: String, Codable {
    case digital = "DIGITAL"
    case empty = ""
}

enum Status: String, Codable {
    case draft = "DRAFT"
    case signing = "SIGNING"
    case signed = "SIGNED"
}

typealias Documents = [Document]

struct DocumentTemp: Codable {
    let id, attachmentID: String?
    let type: Int?
    let title, signingType: String?
    let signatories: [String]?
    let number, startDate, expiryDate, description: String?
    let createdAt, updatedAt, status: String?
    let isInitiator: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case attachmentID = "attachmentId"
        case type, title, signingType, signatories, number, startDate, expiryDate, description, createdAt, updatedAt, status, isInitiator
    }
    
    func getType() -> String {
        switch type {
        case 0: return "Contract"
        case 1: return "Agreement"
        case 2: return "Letter"
        default: return "Document"
        }
    }
    
    func toViewModel(with dateFormat: String?) -> DocumentViewModel {
        let startDate = documentPeriodAdapter(startDate, dateFormat)
        let expiryDate = documentPeriodAdapter(expiryDate, dateFormat)
        let createdAt = documentPeriodAdapter(createdAt, dateFormat)
        let updatedAt = documentPeriodAdapter(updatedAt, dateFormat)
        let type = getType()
        if
            let id = id,
            let attachmentID = attachmentID,
            
            let title = title,
            
            let number = number,
            let description = description,
            let status = status
        {
            let documentVM = DocumentViewModel(id: id, attachmentID: attachmentID, type: type, title: title, description: description, startDate: startDate, endDate: expiryDate, createdAt: createdAt, updatedAt: updatedAt, status: status, number: number)
            return documentVM
        }
        
        let documentVMmock = DocumentViewModel(id: "497b97c8-bf32-4e4f-970b-aaed032821ce", attachmentID: "eb0b2178-1577-4a7a-873f-dceef8cdfd7c", type: "1", title: "asdas", description: "sdasdsads", startDate: "2023-11-22", endDate: "2023-11-30", createdAt: "2023-11-22", updatedAt: "2023-11-22", status: "DRAFT", number: "dasdsa", initiatorFullname: "initiatorFullname", initiatorAvatar: "")
        
        return documentVMmock
    }
    
    private func documentPeriodAdapter(_ date: String?,_ dateFormat: String?) -> String {
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")
        
         if let dateString = date, dateString != "null",
            let date = dateFormatter.date(from: dateString),
                let dateFormat = dateFormat {
             dateFormatter.dateFormat = dateFormat
             return dateFormatter.string(from: date)
         } else {
             return "22.10.2023"
         }
    }
}

