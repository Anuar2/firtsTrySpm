//
//  SelectedDateModel.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

enum SelectedDateFormat {
    case customRange
    case custom
    case today
    case yesterday
    case thisWeek
    case lastSevenDays
    case lastWeek
    case lastTwoWeeks
    case lastMonth
}

struct SelectedDateModel {
    var dateFormat: SelectedDateFormat
    var isSelected: Bool? = false
}
