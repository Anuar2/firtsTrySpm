//
//  SignTypeCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

enum SignType {
    case esp
    case digitalSignature
}

final class SignTypeCell: UITableViewCell {
    
    var selectedOption: SignType? {
        didSet {
            updateUI()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign type"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let espLabel: UILabel = {
        let label = UILabel()
        label.text = "Digital Signature"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let digitalSignatureLabel: UILabel = {
        let label = UILabel()
        label.text = "eSignature"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private let stackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private let stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    let option1Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.radioButtonFilled.name), for: .normal)
        return button
    }()
    
    let option2Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.radioButtonRegular.name), for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(stackView1)
        mainStackView.addArrangedSubview(stackView2)
        
        stackView1.addArrangedSubview(option1Button)
        stackView1.addArrangedSubview(espLabel)
        
        stackView2.addArrangedSubview(option2Button)
        stackView2.addArrangedSubview(digitalSignatureLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        stackView1.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        stackView2.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    private func setupActions() {
        option1Button.addTarget(self, action: #selector(option1ButtonTapped), for: .touchUpInside)
//        option2Button.addTarget(self, action: #selector(option2ButtonTapped), for: .touchUpInside)
    }
    
    private func updateUI() {
        switch selectedOption {
        case .esp:
            option1Button.setImage(UIImage(named: Assets.radioButtonFilled.name), for: .normal)
            option2Button.setImage(UIImage(named: Assets.radioButtonRegular.name), for: .normal)
            
            espLabel.textColor = .black
            digitalSignatureLabel.textColor = .gray
        case .digitalSignature:
            option1Button.setImage(UIImage(named: Assets.radioButtonRegular.name), for: .normal)
            option2Button.setImage(UIImage(named: Assets.radioButtonFilled.name), for: .normal)
            
            digitalSignatureLabel.textColor = .black
            espLabel.textColor = .gray
        case .none:
            option1Button.setImage(UIImage(named: Assets.radioButtonRegular.name), for: .normal)
            option2Button.setImage(UIImage(named: Assets.radioButtonRegular.name), for: .normal)
            digitalSignatureLabel.textColor = .gray
            espLabel.textColor = .gray
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(option1ButtonTapped))
           stackView1.addGestureRecognizer(tapGesture1)
           
//           let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(option2ButtonTapped))
//           stackView2.addGestureRecognizer(tapGesture2)
    }
    
    @objc func option1ButtonTapped() {
        if selectedOption != .esp {
            selectedOption = .esp
        }
    }
    
//    @objc func option2ButtonTapped() {
//        if selectedOption != .digitalSignature {
//            selectedOption = .digitalSignature
//        }
//    }
}
