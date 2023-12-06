//
//  AdDocumentDetailCalendarCell.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

final class AdDocumentDetailCalendarCell: UITableViewCell {
    
    //MARK: - View
    private lazy var startDateButton: UIView = {
        let button = UIView()
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var startDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start date"
        label.font = .systemFont(ofSize: 14)
        label.textColor = DFColor.secondaryVariant
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
        label.textColor = .black
        return label
    }()
    
    private lazy var endDateButton: UIView = {
        let button = UIView()
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var endDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "End date"
        label.font = .systemFont(ofSize: 14)
        label.textColor = DFColor.secondaryVariant
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
        label.textColor = .black
        return label
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
    private func setup() {
        selectionStyle = .none
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [startDateButton, endDateButton].forEach {
            contentView.addSubview($0)
        }
        
        [startDateTitleLabel, startDateIconImageView, startDateLabel].forEach {
            startDateButton.addSubview($0)
        }
        
        [endDateTitleLabel, endDateIconImageView, endDateLabel].forEach {
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
    }
    
    func configure(starteDateTitle: String, endDateTitle: String) {
        startDateLabel.text = starteDateTitle
        endDateLabel.text = endDateTitle
    }
}
