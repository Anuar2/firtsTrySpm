//
//  CreateDocFlowViewController+Section.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

extension CreateDocFlowViewController {
    struct CreateDocFlowSection {
        enum Section {
            case main
        }
        
        enum Row {
            case docNumber
            case docName
            case docType
            case signType
            case signatories
            case docDescription
            case calendar
        }
        
        let section: Section
        var rows: [Row]
    }
}
