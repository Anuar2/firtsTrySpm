//
//  NavBarView.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

final class NavBarView: UIView {
    
    //MARK: - View
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = DFColor.lightTertiary
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.cornerRadius = 8
        view.image = UIImage(named: Assets.documentIcon.name)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Documents"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Medium", size: 16)
        return label
    }()
    
    private lazy var filterIconImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.filterIcon.name), for: .normal)
        button.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Assets.searchIcon.name)
        return view
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
    @objc func filterButtonDidTap() {
        print("filter")
    }
    private func setup() {
        setupLayer()
        setupViews()
        makeConstraints()
    }
    
    private func setupLayer() {
        backgroundColor = DFColor.lightTertiary
    }
    
    private func setupViews() {
        [emptyView, iconImageView, titleLabel, filterIconImageView, searchIconImageView].forEach {
            addSubview($0)
        }
    }
    
    private func makeConstraints() {
        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(44)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
//            make.edges.lessThanOrEqualTo(self).inset(5)
            make.height.width.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
        }
        
        filterIconImageView.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalTo(searchIconImageView.snp.leading).inset(-16)
            make.height.width.equalTo(24)
        }
        
        searchIconImageView.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
    }
}

