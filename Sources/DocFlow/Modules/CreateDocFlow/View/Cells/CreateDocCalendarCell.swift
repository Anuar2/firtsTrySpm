//
//  CreateDocCalendarCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

final class CreateDocCalendarCell: UITableViewCell {
    
    //MARK: - Properties
    var startDate: String? {
        didSet {
            startDateTitleLabel.isHidden = startDate != nil ? false : true
            startDateLabel.textColor = startDate != nil ? .black : DFColor.secondaryVariant
            startDateLabel.text = startDate != nil ? startDate : "Start date"
        }
    }
    
    var endDate: String? {
        didSet {
            endDateTitleLabel.isHidden = endDate != nil ? false : true
            endDateLabel.textColor = endDate != nil ? .black : DFColor.secondaryVariant
            endDateLabel.text = endDate != nil ? endDate : "End date"
        }
    }
    
    var onStartDateButtonDidTap: (() -> ())?
    
    var onEndDateButtonDidTap: (() -> ())?
    //MARK: - View
    private lazy var startDateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(startDateButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var startDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start date"
        label.font = .systemFont(ofSize: 14)
        label.textColor = DFColor.secondaryVariant
        label.isHidden = startDate != nil ? false : true
        return label
    }()
    
    private lazy var startDateIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.image = UIImage(named: "calendarStartIcon")
        return view
    }()
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = startDate != nil ? .black : DFColor.secondaryVariant
        label.text = startDate != nil ? startDate : "Start date"
        return label
    }()
    
    private lazy var startDateSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        return view
    }()
    
    private lazy var endDateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(endDateButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var endDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "End date"
        label.font = .systemFont(ofSize: 14)
        label.textColor = DFColor.secondaryVariant
        label.isHidden = endDate != nil ? false : true
        return label
    }()
    
    private lazy var endDateIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.image = UIImage(named: "calendarEndIcon")
        return view
    }()
    
    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = endDate != nil ? .black : DFColor.secondaryVariant
        label.text = endDate != nil ? endDate : "End date"
        return label
    }()
    
    private lazy var endDateSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        return view
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    @objc private func startDateButtonDidTap() {
        onStartDateButtonDidTap?()
    }
    
    @objc private func endDateButtonDidTap() {
        onEndDateButtonDidTap?()
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [startDateButton, endDateButton].forEach {
            contentView.addSubview($0)
        }
        
        [startDateTitleLabel, startDateIconImageView, startDateLabel, startDateSeparatorView].forEach {
            startDateButton.addSubview($0)
        }
        
        [endDateTitleLabel, endDateIconImageView, endDateLabel, endDateSeparatorView].forEach {
            endDateButton.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        startDateButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(56)
            make.width.equalTo(UIScreen.main.bounds.width/2.3)
        }
        
        startDateTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.equalToSuperview()
            make.height.equalTo(16)
        }
        
        startDateIconImageView.snp.makeConstraints { make in
            make.top.equalTo(startDateTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(startDateTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(startDateIconImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        startDateSeparatorView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        endDateButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
            make.width.equalTo(UIScreen.main.bounds.width/2.3)
        }
        
        endDateTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.equalToSuperview()
            make.height.equalTo(16)
        }
        
        endDateIconImageView.snp.makeConstraints { make in
            make.top.equalTo(endDateTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(endDateTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(endDateIconImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        endDateSeparatorView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func configure(starteDateTitle: String, endDateTitle: String) {
        startDate = starteDateTitle
        endDate = endDateTitle
    }
}
