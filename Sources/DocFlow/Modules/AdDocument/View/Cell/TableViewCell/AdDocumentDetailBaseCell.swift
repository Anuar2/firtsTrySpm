//
//  AdDocumentDetailBaseCell.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import SnapKit

struct AdDocumentDetailBaseCellModel {
    var title: String
    var iconImage: String
    var subtitle: String
}

final class AdDocumentDetailBaseCell: UITableViewCell  {
    
    //MARK: - View
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
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
        contentView.backgroundColor = .white
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [titleLabel,
         iconImageView,
         subtitleLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    public func configure(with model: AdDocumentDetailBaseCellModel) {
        titleLabel.text = model.title
        iconImageView.image = UIImage(named: model.iconImage)
        subtitleLabel.text = model.subtitle
    }
}
