//
//  PreviewAddSignatoriesCell.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

final class PreviewAddSignatoriesCell: UICollectionViewCell {
    
    //MARK: - View
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.layer.cornerRadius = 20
        view.image = UIImage(named: Assets.addMoreIcon.name)
        return view
    }()
    var onAddSignatoriesDidTap: (() -> Void)?

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 12)
        label.text = "Add more"
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tapGesture)
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
        [avatarImageView, fullNameLabel].forEach {
            addSubview($0)
        }
    }
    
    private func makeConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.width.equalTo(40)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    @objc
    private func handleTap() {
         onAddSignatoriesDidTap?()
     }
}
