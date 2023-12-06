//
//  SinatoriesDismissTableViewCell.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

final class SinatoriesDismissTableViewCell: UITableViewCell  {
    
    //MARK: - View
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var doneIconImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.contentMode = .scaleToFill
        view.image = UIImage(named: Assets.signatoriesDismissIcon.name)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = .systemFont(ofSize: 12)
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
         avatarImageView,
         subtitleLabel
        ].forEach {
            contentView.addSubview($0)
        }
        avatarImageView.addSubview(doneIconImageView)
    }
    
    private func makeConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(32)
        }
        
        doneIconImageView.snp.makeConstraints { make in
             make.bottom.trailing.equalTo(avatarImageView)
             make.width.height.equalTo(16)
         }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.height.equalTo(16)
        }
    }
    
    public func configure(with model: FilterInitiatorModel) {
        titleLabel.text = model.fullName
//        avatarImageView.image = UIImage(named: model.iconImage)
        subtitleLabel.text = model.position
    }
}
