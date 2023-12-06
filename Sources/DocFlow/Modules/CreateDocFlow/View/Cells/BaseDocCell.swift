//
//  BaseDocCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol BaseDocCellProtocol {
    var isOnFocus: Bool { get set }
}

struct BaseDocCellModel: BaseDocCellProtocol {
    var isOnFocus: Bool = false
    
    var placeHolder: String = ""
    var editingPlaceholder: String = ""
    var image: UIImage?
    var title: String = ""
}


final class BaseDocCell: UITableViewCell {
    
    var makeFocused: (() -> ())?
    var textChanged: ((String) -> ())?
    
    var createButtonDidTap: Bool = false {
        didSet {
            titleLabel.textColor = (createButtonDidTap && textField.text?.isEmpty == true) ? .red : .black
            separatorView.backgroundColor = (createButtonDidTap && textField.text?.isEmpty == true) ? .red : .gray
        }
    }
    
    var textFieldText: String? {
        didSet {
            textField.text = textFieldText
        }
    }
    
    var editingPlaceholder: String? = ""
    
    var originalPlaceholder: String? = ""
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private let iconImageView = UIImageView()
    let textField = UITextField()
    private let separatorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        
        textField.delegate = self
        makeConstraints()
        addTargets()
    }
    
    private func makeConstraints() {
        [titleLabel, iconImageView, textField, separatorView].forEach {
            self.contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(16)
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(20)
            make.width.equalTo(16)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(16)

        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(2)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-18)
        }

    }
    
    private func addTargets() {
        textField.addTarget(self, action: #selector(textFieldDidStart), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc
    private func textFieldDidStart() {
        separatorView.backgroundColor = .gray
        titleLabel.textColor = UIColor(named: "#007994")

        makeFocused?()
    }
    
    @objc
    private func textFieldDidChanged() {
        guard let textFieldText = textField.text else { return }
        textChanged?(textFieldText)
    }
    
    
    public func configure(with model: BaseDocCellModel) {
        titleLabel.text = model.title
        textField.placeholder = model.placeHolder
        iconImageView.image = model.image
        separatorView.backgroundColor = model.isOnFocus ? UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1) : .gray
        titleLabel.textColor = model.isOnFocus ? UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1) : .gray
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(model.isOnFocus ? 2 : 1)
        }
        
        if textField.hasText {
            titleLabel.isHidden = false
        }
        
        originalPlaceholder = model.placeHolder
        editingPlaceholder = model.editingPlaceholder
    }
}

extension BaseDocCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = editingPlaceholder
        
        titleLabel.isHidden = false
        titleLabel.textColor = DFColor.lightTertiary
        separatorView.backgroundColor = DFColor.lightTertiary
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = originalPlaceholder
        
        titleLabel.isHidden = false
        titleLabel.textColor = .black
        separatorView.backgroundColor = .black
    }
}
