//
//  EmployeeModel.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

struct EmployeeModel: Codable {
    let id, userId, firstName, lastName, firstNameRu, lastNameRu, displayName, photoUrl, workEmail, jobTitle, department, reportsTo, reportsToId, reportsToEmail, status, role, companyId: String?
    let project, division: [String]?
    var checked, allUser, isSelected: Bool
}

