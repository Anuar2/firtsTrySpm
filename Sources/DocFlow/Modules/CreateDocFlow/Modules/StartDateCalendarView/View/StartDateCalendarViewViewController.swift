//
//  StartDateCalendarViewViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import HorizonCalendar
import SnapKit

protocol StartDateCalendarViewDelegate {
    func didPickDate(_ dateString: String)
}

class StartDateCalendarViewViewController: UIViewController, StartDateCalendarViewViewInput {
    
    var output: StartDateCalendarViewViewOutput?
    
    var delegate: StartDateCalendarViewDelegate?
    
    var selectedDay: Day? {
        didSet {
            if let selectedDay = selectedDay {
                applyButton.setTitle("Select \(self.convertDateToString(day: selectedDay))", for: .normal)
            } else {
                applyButton.setTitle("Apply", for: .normal)
            }
        }
    }
    
    //MARK: - View
    private lazy var navigationView: DFFloatingPanelNavBar = {
        let view = DFFloatingPanelNavBar()
        view.navigationTitle = "Start date"
        return view
    }()
    
    
    private lazy var calendarView: CalendarView = {
        let calendar = CalendarView(initialContent: makeCalendarContent())
        calendar.backgroundColor = .white
        return calendar
    }()
    
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = DFColor.primary
        button.layer.cornerRadius = 12
        button.setTitle("Apply", for: .normal)
        button.addTarget(self, action: #selector(applyButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        view.backgroundColor = DFColor.lighBackground
        setup()
    }
    
    
    // MARK: StartDateCalendarViewViewInput
    func setupInitialState() {
    }
    
    //MARK: - Methdos
    @objc private func applyButtonDidTap() {
        if let selectedDay = selectedDay {
            delegate?.didPickDate(convertDateToString(day: selectedDay))
            output?.dismiss()
        }
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
        updateCalendarView()
    }
    
    private func setupViews() {
        [navigationView, calendarView, applyButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(applyButton.snp.top).inset(-8)
        }
        
        applyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    private func makeCalendarContent() -> CalendarViewContent {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US")
        let today = Date()
        let endDate = calendar.date(from: DateComponents(year: 2031, month: 12, day: 31))!
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: today...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions(pinDaysOfWeekToTop: true)))
        .verticalDayMargin(4)
        .horizontalDayMargin(4)
        .interMonthSpacing(16)
        
        .dayItemProvider { day in
            var invariantViewProperties = DayLabel.InvariantViewProperties(
                font: UIFont.systemFont(ofSize: 14),
                textColor: .darkGray,
                backgroundColor: .clear, borderColor: UIColor.clear.cgColor)
            
            if day == self.selectedDay {
                invariantViewProperties.textColor = .white
                invariantViewProperties.backgroundColor = DFColor.lightTertiary
            }
            
            return DayLabel.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                viewModel: .init(content: .init(day: day)))
        }
    }
    
    private func updateCalendarView() {
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self = self else { return }
            
            self.selectedDay = day
            
            let newContent = self.makeCalendarContent()
            self.calendarView.setContent(newContent)
        }
    }
    
    private func convertDateToString(day: Day) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let myDate = dateFormatter.date(from: String(describing: day.description))
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let dateString = dateFormatter.string(from: myDate!)
        
        return dateString
    }
}
