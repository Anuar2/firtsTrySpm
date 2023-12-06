//
//  FilterInitiatorModel.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

struct FilterInitiatorModel: Equatable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var position: String?
    var avatar: String?
    var isSelected: Bool = false
    
    var fullName: String {
        if let firstName = firstName {
            if let lastName = lastName {
                return "\(String(describing: firstName)) \(String(describing: lastName))"
            }
            return "\(String(describing: firstName))"
        }
        return ""
    }
}
