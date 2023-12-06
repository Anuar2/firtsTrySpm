//
//  FilterViewController+Section.swift
//
//
//  Created by User on 05.12.2023.
//

extension FilterViewController {
    struct FilterSection {
        enum Section {
            case main
        }
        
        enum Row {
            case docType
            case docStatus
            case initiator
            case lastModified
            case creationDate
            case expiryDate
        }
        
        let section: Section
        var rows: [Row]
    }
}
