//
//  ServicesViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class ServicesViewController: UIViewController, ServicesViewInput {

    var output: ServicesViewOutput?
    
    //MARK: - View
    private lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = DFColor.lightTertiary
        return view
    }()
    
    private lazy var showDocumentListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Documents", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(showDocumentsButtonDidTap), for: .touchUpInside)
        return button
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        view.backgroundColor = DFColor.lighBackground
        setup()
    }


    // MARK: ServicesViewInput
    func setupInitialState() {
    }
    
    //MARK: - Methods
    @objc func showDocumentsButtonDidTap(_ sender: UIButton) {
        output?.showDocumentsButtonDidTap()
    }
    
    private func setup() {
        setupNavigation()
        setupViews()
        makeConstraints()
    }
    
    private func setupNavigation() {
        let titleLabel = UILabel()
        titleLabel.text = "Services"
        titleLabel.textColor = .white
        let titleBarBUtton = UIBarButtonItem(customView: titleLabel)
        
        let iconImageView = UIImageView()
        iconImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        iconImageView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        iconImageView.layer.cornerRadius = 8
        iconImageView.image = UIImage(named: Assets.servicesIcon.name)
        iconImageView.contentMode = .scaleAspectFit
        let iconImageBarBUtton = UIBarButtonItem(customView: iconImageView)
        
        navigationItem.setLeftBarButtonItems([iconImageBarBUtton,titleBarBUtton], animated: true)
        
        navigationController?.navigationBar.backgroundColor = DFColor.lightTertiary
    }
    
    private func setupViews() {
        [navigationView, showDocumentListButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(92)
        }
        showDocumentListButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }
}
