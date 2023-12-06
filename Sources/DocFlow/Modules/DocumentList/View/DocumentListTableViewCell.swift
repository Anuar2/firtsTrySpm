//
//  DocumentListTableViewCell.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import SnapKit

final class DocumentListTableViewCell: UITableViewCell {
    //MARK: - View
    private lazy var cellView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        view.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        return view
    }()
    
    private lazy var docNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    private lazy var docTypeView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        return view
    }()
    
    private lazy var docTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    private lazy var docStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Assets.purpleDocStatus.name)
        return imageView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        view.image = UIImage(named: Assets.avatarIcon.name)
        return view
    }()
    
    private lazy var initiatorTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    private lazy var docStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
    private func setup() {
        setupLayer()
        setupViews()
        makeConstraints()
    }
    
    private func setupLayer() {
        selectionStyle = .none
        backgroundColor = .clear
        autoresizingMask = [.flexibleHeight]
    }
    
    private func setupViews() {
        [cellView, footerView].forEach {
            contentView.addSubview($0)
        }
        
        [docNumberLabel,
         docTypeView,
         nameLabel,
         startDateLabel,
         endDateLabel,
         docStatusImageView,
         docStatusLabel,
         avatarImageView,
         initiatorTitleLabel
        ].forEach {
            cellView.addSubview($0)
        }
        
        docTypeView.addSubview(docTypeLabel)
    }
    
    private func makeConstraints() {
        cellView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
            make.height.equalTo(140)
        }
        
        footerView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(cellView.snp.bottom)
            make.height.equalTo(8)
        }
        
        docNumberLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        docTypeView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        docTypeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(4)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(docNumberLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(startDateLabel.snp.trailing).offset(4)
            make.height.equalTo(18)
        }
        
        docStatusImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8.7)
            make.leading.equalTo(endDateLabel.snp.trailing).offset(8)
            make.size.equalTo(18)
        }
        
        docStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(docStatusImageView.snp.trailing).offset(4)
            make.height.equalTo(18)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(docStatusLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        initiatorTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView.snp.centerY)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
    }
    
    public func configure(with model: DocumentViewModel) {
        docNumberLabel.text = model.number
        docTypeLabel.text = model.type
        nameLabel.text = model.title
        startDateLabel.text = "\(model.startDate ?? "") →"
        endDateLabel.text = model.endDate
        docStatusLabel.text = model.status
        initiatorTitleLabel.text = model.initiatorFullname
//        avatarImageView.image = UIImage(named: model.initiatorAvatar)
    }
}
