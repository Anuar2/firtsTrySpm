//
//  DayLabel.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import HorizonCalendar

struct DayLabel: CalendarItemViewRepresentable {
    typealias ViewType = UILabel
    
    struct ViewModel: Equatable {
        let content: Content
    }

    struct InvariantViewProperties: Hashable {
        let font: UIFont
        var textColor: UIColor
        var backgroundColor: UIColor
        var borderColor: CGColor
    }

    struct Content: Equatable {
        let day: Day
    }

    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
        -> UILabel
    {
        let label = UILabel()

        label.backgroundColor = invariantViewProperties.backgroundColor
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor
        label.layer.borderColor = invariantViewProperties.borderColor

        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 12

        return label
    }

    static func setContent(_ content: Content, on view: UILabel) {
        view.text = "\(content.day.day)"
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
        view.text = "\(viewModel.content.day.day)"
    }
}

