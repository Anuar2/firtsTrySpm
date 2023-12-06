//
//  StartDateCalendarViewFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol StartDateCalendarViewFactory {
    func makeStartDateCalendarView() -> StartDateCalendarViewViewController
}

extension ModulesFactory: StartDateCalendarViewFactory {
    func makeStartDateCalendarView() -> StartDateCalendarViewViewController {
        StartDateCalendarViewModuleConfigurator().build(factory: self)
    }
}
