//
//  SelectedSignatureCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import SnapKit

final class SelectedSignatureCell: UITableViewCell {
    
    var deleteCallback: (() -> Void)?

    //MARK: - View
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeIcon"), for: .normal)
        button.addTarget(self, action: #selector(removeSignators), for: .touchUpInside)
        return button
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
        [avatarImageView, fullNameLabel, deleteButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(32)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(28)
        }
    }
    
    @objc
    private func removeSignators() {
        deleteCallback?()
    }
    
    public func configure(with model: FilterInitiatorModel) {
        fullNameLabel.text = model.fullName
    }
}
