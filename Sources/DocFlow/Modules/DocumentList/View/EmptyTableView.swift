//
//  EmptyTableView.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import SnapKit

protocol EmptyTableViewModelProtocol {
    var image: String {get set}
    var title: String {get set}
    var subtitle: String {get set}
}

struct EmptyTableViewModel {
    var image: String
    var title: String
    var subtitle: String
}

final class EmptyTableView: UIView {
    //MARK: - View
    private lazy var documentAddImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Assets.documentAddIcon.name)
        view.layer.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.969, alpha: 1).cgColor
        view.layer.cornerRadius = 120
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No documents"
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Medium", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "To get started, tap on the «+ Document»."
        label.textColor = UIColor(red: 0.545, green: 0.549, blue: 0.62, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        label.textAlignment = .center
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
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [documentAddImageView, titleLabel, subtitleLabel].forEach {
            addSubview($0)
        }
    }
    
    private func makeConstraints() {
        documentAddImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(documentAddImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
    
    public func configure(with viewModel: EmptyTableViewModelProtocol) {
        documentAddImageView.image = UIImage(named: viewModel.image)
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}

