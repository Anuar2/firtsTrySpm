//
//  CalendarEntity.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

enum CalendarCategory: String {
    case custom = "Custom"
    case today = "Today"
    case yesterday = "Yesterday"
    case week = "This week (Mon - Today)"
}

struct SearchCalendarCategory {
    var calendarCategory: CalendarCategory
    var isSelected: Bool = false
}
