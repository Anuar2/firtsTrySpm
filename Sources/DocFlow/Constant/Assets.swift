//
//  File.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation
import UIKit

internal enum Assets: String {
    //MARK: - Document
    case documentAddIcon
    case docStatusIcon
    case purpleDocStatus
    case documentIcon
    case filterIcon
    case searchIcon
    case chevronRIghtIcon
    case checkIcon
    case uncheckIcon
    case backButtonIcon
    case avatarIcon
    case addDocumentButton
    
    //MARK: - TabBar
    case homeIcon
    case myWorkIcon
    case chatIcon
    case peopleTeamIcon
    case servicesIcon
    
    //MARK: - CreateDocFlow
    case documentNumberIcon
    case documentNameIcon
    case agreementIcon
    case signatureIcon
    case descriptionIcon
    case radioButtonFilled
    case radioButtonRegular
    case chevronDownIcon
    case closeIcon
    case pdfIcon
    case doc
    case uploadDocumentIcon
    case calendarStartIcon
    case calendarEndIcon
    case addMoreIcon
    case signIcon
    case spinnerIcon


    //MARK: - EditDocumentInfo
    case personAddIcon
    case documentEditIcon
    case textDescriptionIcon
    case calendarAddIcon
    case calendarEditIcon
    case doneSignatioriesIcon
    case signatoriesDismissIcon
    
    //MARK: - ActionsDocument
    case adActionIcon
    case editRegular
    case downloadIcon
    case voidIcon
    case deleteIcon
    
    public var name: String {
        return self.rawValue
    }
    
    public var image: UIImage? {
        return UIImage(named: rawValue)
    }
}

