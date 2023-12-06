//
//  SelectedInitiatorCellView.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

final class SelectedInitiatorCellView: UITableViewCell {
    
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "chekIcon")
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 12)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [iconImageView, avatarImageView, titleLabel, subtitleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.height.width.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.height.equalTo(12)
        }
    }
    
    public func configure(with model: FilterInitiatorModel) {
        if let firstName = model.firstName, let lastName = model.lastName {
            titleLabel.text = "\(firstName) \(lastName)"
        }
    }
}
