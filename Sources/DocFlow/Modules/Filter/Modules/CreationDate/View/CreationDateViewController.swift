//
//  CreationDateViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import HorizonCalendar
import SnapKit

protocol CreationDateViewControllerDelegate: AnyObject {
    func didSelectDateRange(dateFrom: String, dateTo: String)
}

class CreationDateViewController: UIViewController, CreationDateViewInput {
    
    var output: CreationDateViewOutput?
    var delegate: CreationDateViewControllerDelegate?
    var dateRange: DateRange?

    var isClearRangeDateColor = false
    var dateCategory: [SearchCalendarCategory] = [.init(calendarCategory: .custom),
                                                  .init(calendarCategory: .today),
                                                  .init(calendarCategory: .yesterday),
                                                  .init(calendarCategory: .week)]
    
    var isTodaySelected: Bool = false
    var isYesterdaySelected: Bool = false
    var isWeekSelected: Bool = false
    
    var today: Date {
        return Date()
    }
    
    var week: [Date] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        var weekDates: [Date] = []
        guard let startOfWeek = calendar.date(from: components) else {
            return []
        }
        weekDates.append(startOfWeek)
        if let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) {
            weekDates.append(endOfWeek)
        }
        
        return weekDates
    }
    
    
    var selectedCatgory: SearchCalendarCategory? = .init(calendarCategory: .custom) {
        didSet {
            updateCalendarView()
        }
    }

    var selectedDays: [Day] = [] {
        didSet {
            selectedDays = selectedDays.sorted()
            if !selectedDays.isEmpty {
                dateFromDateLabel.text = self.convertDayToString(day: selectedDays[0])
                if selectedDays.count > 1 {
                    dateToDateLabel.text = self.convertDayToString(day: selectedDays[1])
                }
            }
        }
    }
    
    //MARK: - View
    private lazy var navigationView: DFFloatingPanelNavBar = {
        let view = DFFloatingPanelNavBar()
        view.navigationTitle = "Start date"
        return view
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateFromView = UIView()
    
    private lazy var dateFromTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Date from"
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var dateFromDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var dateFromSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var dateToView = UIView()
    
    private lazy var dateToTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Date to"
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var dateToDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var dateToSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(cellClass: CalendarCollectionViewCell.self)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var calendarView: CalendarView = {
        let calendar = CalendarView(initialContent: makeCalendarContent())
        return calendar
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.88, green: 0.381, blue: 0.229, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(applyButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        view.backgroundColor = .white
        setup()
    }
    
    
    // MARK: CreationDateViewInput
    func setupInitialState() {
    }
    
    //MARK: - Methdos
    private func setup() {
        setupViews()
        makeConstraints()
        updateCalendarView()
    }
    
    private func setupViews() {
        [navigationView, dateFromView, dateToView, calendarView, applyButton, clearButton, collectionView].forEach {
            view.addSubview($0)
        }
        
        [dateFromTitleLabel, dateFromDateLabel, dateFromSeparatorView].forEach {
            dateFromView.addSubview($0)
        }
        
        [dateToTitleLabel, dateToDateLabel, dateToSeparatorView].forEach {
            dateToView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(28)
        }
        
        dateFromView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(14)
            make.height.equalTo(56)
            make.width.equalTo(UIScreen.main.bounds.width/2.2)
        }
        
        dateFromTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
        
        dateFromDateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateFromTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(18)
        }
        
        dateFromSeparatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        dateToView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(14)
            make.height.equalTo(56)
            make.width.equalTo(UIScreen.main.bounds.width/2.2)
        }
        
        dateToTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
        
        dateToDateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateToTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(18)
        }
        
        dateToSeparatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dateFromView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        applyButton.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(40)
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
                backgroundColor: .clear,
                borderColor: UIColor.clear.cgColor
            )
            
            if self.convertDayToString(day: day) == self.convertDateString(String(describing: today)) {
                if self.selectedCatgory?.calendarCategory.rawValue == CalendarCategory.today.rawValue {
                    invariantViewProperties.textColor = .white
                    invariantViewProperties.backgroundColor = UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1)
                    invariantViewProperties.borderColor = UIColor.clear.cgColor
                } else {
                    invariantViewProperties.textColor = .black
                    invariantViewProperties.backgroundColor = UIColor(red: 0.871, green: 0.969, blue: 0.988, alpha: 1)
                    invariantViewProperties.borderColor = UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1).cgColor
                }
            }
            
            if self.convertDayToString(day: day) == self.convertDateString(String(describing: today.dayBefore)), self.selectedCatgory?.calendarCategory == CalendarCategory.yesterday {
                invariantViewProperties.textColor = .white
                invariantViewProperties.backgroundColor = DFColor.lightTertiary
                invariantViewProperties.borderColor = UIColor.clear.cgColor
            }
            
            if self.selectedCatgory?.calendarCategory == CalendarCategory.week {
                if self.convertDayToString(day: day) == self.convertDateString(String(describing: self.week[0])) || self.convertDayToString(day: day) == self.convertDateString(String(describing: self.week[1])) {
                    invariantViewProperties.textColor = .white
                    invariantViewProperties.backgroundColor = DFColor.lightTertiary
                }
                
                if self.convertDayToString(day: day) > self.convertDateString(String(describing: self.week[0])) ?? "" && self.convertDayToString(day: day) < self.convertDateString(String(describing: self.week[1])) ?? "" {
                    invariantViewProperties.textColor = .white
                    invariantViewProperties.backgroundColor = DFColor.lightTertiary.withAlphaComponent(0.5)
                }
            }
            
            if let startDate = self.dateRange?.startDate, let endDate = self.dateRange?.endDate {
                if day >= startDate && day <= endDate {
                    invariantViewProperties = DayLabel.InvariantViewProperties(
                        font: UIFont.systemFont(ofSize: 14),
                        textColor: self.isClearRangeDateColor ? .darkGray : .white,
                        backgroundColor: self.isClearRangeDateColor ? .clear : DFColor.lightTertiary.withAlphaComponent(0.5), borderColor: UIColor.clear.cgColor)
                }
            }
            
            self.selectedDays.forEach { selectedDay in
                if day == selectedDay, self.selectedCatgory?.calendarCategory == CalendarCategory.custom {
                    invariantViewProperties.textColor = .white
                    invariantViewProperties.backgroundColor = DFColor.lightTertiary
                }
            }
            
            return DayLabel.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                viewModel: .init(content: .init(day: day)))
        }
    }
    
    private func updateCalendarView() {
        switch selectedCatgory?.calendarCategory {
        case .custom:
            selectedDays.removeAll()
            dateRange = .init()
            calendarView.daySelectionHandler = { [weak self] day in
                guard let self = self else { return }
                
                if let index = self.selectedDays.firstIndex(of: day) {
                    self.selectedDays.remove(at: index)
                    self.clearButton.setTitleColor(.gray, for: .normal)
                } else {
                    if self.selectedDays.count < 2 {
                        self.selectedDays.append(day)
                        self.clearButton.setTitleColor(UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1), for: .normal)
                    } else {
                        self.selectedDays[1] = day
                    }
                }
                
                self.dateRange = DateRange(startDate: self.selectedDays.first, endDate: self.selectedDays.last)
                
                self.selectedDays = self.selectedDays.sorted(by: {$0.day > $1.day && $0.month > $1.month})
                self.isClearRangeDateColor = false
                let newContent = self.makeCalendarContent()
                self.calendarView.setContent(newContent)
            }
        case .today:
            calendarView.daySelectionHandler = nil
            selectedDays.removeAll()
            dateRange = .init()
            if let today = self.convertDateString(String(describing: Date())) {
                dateFromDateLabel.text = today
                dateToDateLabel.text = today
            }
            self.isClearRangeDateColor = false
            let newContent = self.makeCalendarContent()
            self.calendarView.setContent(newContent)
        case .none:
            print("none")
        case .yesterday:
            calendarView.daySelectionHandler = nil
            selectedDays.removeAll()
            dateRange = .init()
            if let yesterday = convertDateString(String(describing: Date().dayBefore)) {
                dateFromDateLabel.text = yesterday
                dateToDateLabel.text = yesterday
            }
            self.isClearRangeDateColor = false
            let newContent = self.makeCalendarContent()
            self.calendarView.setContent(newContent)
        case .week:
            calendarView.daySelectionHandler = nil
            selectedDays.removeAll()
            dateRange = .init()
            
            guard let startDateString = convertDateString(String(describing: week[0])) else {
                return
            }
            
            if let endDateString = convertDateString(String(describing: week[1])) {
                dateFromDateLabel.text = startDateString
                dateToDateLabel.text = endDateString
            }
            
            self.isClearRangeDateColor = false
            let newContent = self.makeCalendarContent()
            self.calendarView.setContent(newContent)
        }
        
    }
    
    private func convertDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM d, yyyy"
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let resultString = outputFormatter.string(from: date)
            return resultString
        } else {
            return nil
        }
    }
    
    private func convertDayToString(day: Day) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let myDate = dateFormatter.date(from: String(describing: day.description))
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let dateString = dateFormatter.string(from: myDate!)
        
        return dateString
    }
    
    @objc private func applyButtonDidTap() {
        if let dateFrom = dateFromDateLabel.text, let dateTo = dateToDateLabel.text {
            delegate?.didSelectDateRange(dateFrom: dateFrom, dateTo: dateTo)
            dismiss(animated: true)
        }
    }
    
    @objc
    private func clearTapped() {
        selectedDays.removeAll()
        
        let newContent = makeCalendarContent()
        calendarView.setContent(newContent)
        
        self.clearButton.setTitleColor(.gray, for: .normal)
        updateCalendarView()
        isClearRangeDateColor = true
        dateFromDateLabel.text = ""
        dateToDateLabel.text = ""
        
        for (index, _) in dateCategory.enumerated() {
            dateCategory[index].isSelected = false
        }
        
        selectedCatgory = nil

        collectionView.reloadData()
    }
}

struct DateRange {
    var startDate: Day?
    var endDate: Day?
}
