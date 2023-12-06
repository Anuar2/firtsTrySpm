//
//  DocumentAdModel.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

enum DocType: String {
    case type1 = "Purchase and Sale Agreement"
    case type2 = "Supply Agreement"
    case type3 = "Rental Agreement"
    case type4 = "Contract for Gratuitous Provision of Services"
    case type5 = "Service Contract"
    case type6 = "Loan Agreement"
    case type7 = "Insurance Agreement"
    case type8 = "License Agreement"
    case type9 = "Advertising Services Agreement"
    case type10 = "Civil Law Agreement with an Individual"
    case type11 = "NDA"
    case type12 = "Supplementary Agreement"
}

enum DocStatus: String {
    case draft = "DRAFT"
    case onSigning = "SIGNING"
    case signed = "SIGNED"
}

struct DocumentAdModel {
    var docNumber: String?
    var docType: DocType?
    var docTypeText: String?
    var docName: String?
    var docStatus: DocStatus?
    var docDiscription: String?
    var startDate: String?
    var endDate: String?
    var initiator: [FilterInitiatorModel]?
}



