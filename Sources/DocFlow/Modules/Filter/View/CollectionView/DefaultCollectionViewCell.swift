//
//  DefaultCollectionViewCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import SnapKit

final class DefaultCollectionViewCell: UICollectionViewCell {
    
    //MARK: - View
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        layer.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.988, alpha: 1).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.08).cgColor
    }
    
    private func setupViews() {
        [titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(18)
        }
    }
    
    public func configure(title: String, isSelected: Bool) {
        titleLabel.text = title
        titleLabel.textColor = isSelected ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        layer.backgroundColor = isSelected ? UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1).cgColor : UIColor(red: 0.969, green: 0.973, blue: 0.988, alpha: 1).cgColor
    }
}
