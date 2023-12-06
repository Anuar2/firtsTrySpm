//
//  SignaturesCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import SnapKit

final class SignaturesCell: UITableViewCell {
    
    //MARK: - Properties
    var signaturesList: [FilterInitiatorModel] = [] {
        didSet {
            onReceiveDataCallback?()
        }
    }
    
    var onReceiveDataCallback: (() -> Void)?
    var signatureTapped: (() -> Void)?
    
    //MARK: - View
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "signatureIcon")
        return view
    }()
    
    private lazy var backgroundButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(signaturesTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.545, green: 0.549, blue: 0.62, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.text = "Signatories"
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "chevronDownIcon")
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        return view
    }()
    
    private lazy var mainTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(cellClass: SelectedSignatureCell.self)
        return view
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methdos
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [iconImageView, titleLabel, chevronImageView, separatorView].forEach {
            backgroundButton.addSubview($0)
        }
        [backgroundButton, mainTableView].forEach {
            contentView.addSubview($0)
        }
    }
        
    private func makeConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.height.equalTo(24)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(backgroundButton.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(0)
        }
    }
    
    func callBackRecieve(signaturesList: [FilterInitiatorModel]) {
        if signaturesList.isEmpty {
            mainTableView.isHidden = true
            mainTableView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            mainTableView.reloadData()
        } else {
            mainTableView.isHidden = false
            mainTableView.snp.updateConstraints { make in
                make.height.equalTo(signaturesList.count * 48)
            }
            self.signaturesList = signaturesList
            mainTableView.reloadData()
            onReceiveDataCallback?()
        }
    }
    
    @objc private func signaturesTapped() {
        signatureTapped?()
    }
}

//MARK: - UITableViewDataSource
extension SignaturesCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signaturesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = signaturesList[indexPath.row]
        
        let cell: SelectedSignatureCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: model)
        cell.deleteCallback = { [weak self] in
            if let index = self?.mainTableView.indexPath(for: cell) {
                self?.signaturesList.remove(at: index.row)
                self?.mainTableView.deleteRows(at: [index], with: .fade)
                
                if self?.signaturesList.isEmpty == true {
                    self?.mainTableView.isHidden = true
                    self?.mainTableView.snp.updateConstraints { make in
                        make.height.equalTo(0)
                    }
                }
                self?.mainTableView.reloadData()
                self?.onReceiveDataCallback?()
            }
        }

        return cell
    }
}

//MARK: - UITableViewDelegate
extension SignaturesCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
