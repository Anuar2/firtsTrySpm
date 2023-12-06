//
//  UploadDocumentViewCell.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

final class UploadDocumentViewCell: UITableViewCell {
    
    //MARK: - Properties
    var selectedFileURL: URL? {
        didSet {
            setupViewStatus()
        }
    }
    
    var onPickButtonDidTap: (() -> ())?
    
    //MARK: - View
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Document for signature"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var addDocumentButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        button.addTarget(self, action: #selector(addDocumentButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonIconImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.988, alpha: 1)
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: Assets.uploadDocumentIcon.name)
        return view
    }()
    
    private lazy var buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Upload from your device"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var chevronIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Assets.chevronRIghtIcon.name)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Permitted files .pdf, .docx no more than 50 MB"
        label.textColor = UIColor(red: 0.545, green: 0.549, blue: 0.62, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private lazy var documentTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.988, alpha: 1)
        view.layer.cornerRadius = 12
        view.isHidden = true
        return view
    }()
    
    private lazy var docIconImageView: UIImageView = {
        let view = UIImageView()
        view.isHidden = true
        return view
    }()
    
    private lazy var documentTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    private lazy var deleteDocumentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.closeIcon.name), for: .normal)
        button.addTarget(self, action: #selector(deleteDocumentButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var loaderView = CustomLoaderView()
    
    private let separatorView = UIView()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    @objc private func addDocumentButtonDidTap() {
        onPickButtonDidTap?()
    }
    
    @objc private func deleteDocumentButtonDidTap() {
        selectedFileURL = nil
        documentTitleLabel.text = nil
        setupViewStatus()
    }
    
    private func setup() {
        setupViews()
        setupViewStatus()
        makeConstraitns()
    }
    
    private func setupViews() {
        [titleLabel, addDocumentButton, noteLabel, documentTitleView, separatorView].forEach {
            contentView.addSubview($0)
        }
        
        [docIconImageView, documentTitleLabel, deleteDocumentButton, loaderView].forEach {
            documentTitleView.addSubview($0)
        }
        
        [buttonIconImageView, buttonTitleLabel, chevronIconImageView].forEach {
            addDocumentButton.addSubview($0)
        }
    }
    
    private func makeConstraitns() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(16)
        }
        
        addDocumentButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        buttonIconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(12)
            make.height.width.equalTo(32)
        }
        
        buttonTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(buttonIconImageView.snp.trailing).offset(12)
            make.trailing.equalTo(chevronIconImageView.snp.leading).offset(-8)
            make.height.equalTo(18)
        }
        
        chevronIconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(12)
            make.height.width.equalTo(20)
        }
        
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(addDocumentButton.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(16)
        }
        
        documentTitleView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        docIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(12)
            make.height.width.equalTo(24)
        }
        
        loaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(12)
            make.height.width.equalTo(24)
        }
        
        documentTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalTo(docIconImageView.snp.trailing).offset(12)
            make.trailing.equalTo(deleteDocumentButton.snp.leading).offset(-12)
            make.height.equalTo(18)
        }
        
        deleteDocumentButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(addDocumentButton.snp.bottom).offset(2)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
    
    private func setupViewStatus() {
        [documentTitleView, docIconImageView, documentTitleLabel].forEach {
            $0.isHidden = selectedFileURL == nil ? true : false
        }
        
        [addDocumentButton].forEach {
            $0.isHidden = selectedFileURL == nil ? false : true
        }
        
        loaderView.startAnimating()
        docIconImageView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loaderView.stopAnimating()
            self.docIconImageView.isHidden = false
            self.docIconImageView.image = UIImage(named: self.selectedFileURL?.lastPathComponent.contains("pdf") == true ? Assets.pdfIcon.name : Assets.doc.name)
        }
    }
    
    public func configure(url: URL?, onPickButtonDidTap: (()->())?) {
        self.selectedFileURL = url
        self.onPickButtonDidTap = onPickButtonDidTap
        setupViewStatus()
    }
}
