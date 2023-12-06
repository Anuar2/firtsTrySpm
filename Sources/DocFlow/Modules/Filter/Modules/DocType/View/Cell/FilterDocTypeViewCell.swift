//
//  FilterDocTypeViewCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import SnapKit

final class FilterDocTypeViewCell: UITableViewCell {
    
    //MARK: - View
    private lazy var iconImageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
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
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [iconImageView, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
    }
    
    public func configure(with model: FilterDocTypeModel) {
        titleLabel.text = model.docType.rawValue
        iconImageView.image = model.isSelected ? UIImage(named: "checkIcon") : UIImage(named: "unchekIcon")
    }
}
