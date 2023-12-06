//
//  AdDocumentDetailOverViewCell.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import SnapKit

final class AdDocumentDetailOverViewCell: UITableViewCell  {
    
    //MARK: - View
    private lazy var documentIdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = .systemFont(ofSize: 14)
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var statusIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Assets.purpleDocStatus.name)
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var signTypeIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Assets.documentEditIcon.name)
        return view
    }()
    
    private lazy var signTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Digital signature"
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
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
        contentView.backgroundColor =  UIColor(red: 0.969, green: 0.973, blue: 0.988, alpha: 1)
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [documentIdLabel,
         docTypeView,
         titleLabel,
         statusIconImageView,
         statusLabel,
         signTypeIconImageView,
         signTypeLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        docTypeView.addSubview(docTypeLabel)
    }
    
    private func makeConstraints() {
        documentIdLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
        }
        
        docTypeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.greaterThanOrEqualTo(documentIdLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        docTypeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(documentIdLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        statusIconImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(18)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(statusIconImageView.snp.trailing).offset(2)
        }
        
        signTypeIconImageView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(18)
        }
        
        signTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.leading.equalTo(signTypeIconImageView.snp.trailing).offset(2)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    public func configure(with model: DocumentViewModel) {
        titleLabel.text = model.title
        statusLabel.text = model.status
        documentIdLabel.text = "ID:\(model.id)"
        docTypeLabel.text = model.type
    }
}
