//
//  PublishedDocumentAlertViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol PublishedDocumentAlertDelegate: AnyObject {
    func saveDocumentToHome()
}

class PublishedDocumentAlertViewController: UIViewController, PublishedDocumentAlertViewInput {

    var output: PublishedDocumentAlertViewOutput?
    weak var delegate: PublishedDocumentAlertDelegate?
    
    //MARK: - View
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var signImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Assets.signIcon.name)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your document was sent for signing"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    private lazy var backgroundButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign this document now?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var actionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = DFColor.lighBackground
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign now", for: .normal)
        button.backgroundColor = DFColor.primary
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var notSaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign later", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var emptyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        
        setup()
    }


    // MARK: SaveDocumentAlertViewInput
    func setupInitialState() {
    }
    
    //MARK: - Methods
    @objc private func saveButtonDidTap() {
        output?.dissmiss()
        delegate?.saveDocumentToHome()
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [backgroundView, mainView].forEach {
            view.addSubview($0)
        }
        
        backgroundView.addSubview(backgroundButton)
        
        [signImageView, titleLabel, subtitleLabel, separatorView, actionView].forEach {
            mainView.addSubview($0)
        }
        
        [saveButton, notSaveButton, emptyButton].forEach {
            actionView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(330)
            make.centerY.equalToSuperview()
        }

        signImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalTo(mainView)
            make.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(signImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }

        actionView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        saveButton.snp.makeConstraints { make in
            make.leading.bottom.equalTo(actionView).inset(16)
            make.trailing.equalTo(actionView.snp.centerX).offset(-4)
            make.height.equalTo(40)
        }

        notSaveButton.snp.makeConstraints { make in
            make.leading.equalTo(actionView.snp.centerX).offset(4)
            make.bottom.equalTo(actionView).inset(16)
            make.trailing.equalTo(actionView).inset(16)
            make.height.equalTo(40)
        }
    }
    
    @objc private func dismissButtonTapped() {
        output?.dissmiss()
    }
}
