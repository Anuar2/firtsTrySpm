//
//  EndDateCalendarViewFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol EndDateCalendarViewFactory {
    func makeEndDateCalendarView() -> EndDateCalendarViewViewController
}

extension ModulesFactory: EndDateCalendarViewFactory {
    func makeEndDateCalendarView() -> EndDateCalendarViewViewController {
        EndDateCalendarViewModuleConfigurator().build(factory: self)
    }
}
