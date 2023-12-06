//
//  DocumentActionsViewController + Section.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

extension DocumentActionsViewController {
    struct DocumentActionsSection {
        enum Section {
            case main
        }
        
        enum Row {
            case edit
            case download
            case void
            case delete
        }
        
        let section: Section
        var rows: [Row]
    }
}
