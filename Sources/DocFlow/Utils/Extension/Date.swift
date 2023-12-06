//
//  Date.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

extension Date {
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
