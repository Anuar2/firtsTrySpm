//
//  DocumentActionsCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

final class DocumentActionsCell: UITableViewCell {
    
    
    var roundTopCorners: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    var roundBottomCorners: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    //MARK: - View
    private lazy var titleView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if roundTopCorners && roundBottomCorners {
            titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else if roundTopCorners {
            titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if roundBottomCorners {
            titleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            titleView.layer.maskedCorners = []
        }
        
        titleView.layer.cornerRadius = 10.0
    }
    
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
        backgroundColor = DFColor.lighBackground
    }
    
    private func setupViews() {
        [titleView].forEach {
            contentView.addSubview($0)
        }
        
        [titleLabel, iconImageView].forEach {
            titleView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.height.equalTo(18)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.height.width.equalTo(20)
        }
    }
    
    public func configure(title: String, icon: String) {
        titleLabel.text = title
        iconImageView.image = UIImage(named: icon)
    }
}
