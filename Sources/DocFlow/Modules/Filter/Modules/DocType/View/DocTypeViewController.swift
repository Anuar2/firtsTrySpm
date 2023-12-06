//
//  DocTypeViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol DocTypeViewControllerProtocol {
    func didSelectDocType(_ selectedDocTypes: [FilterDocTypeModel])
}

class DocTypeViewController: UIViewController, DocTypeViewInput {

    var output: DocTypeViewOutput?
    
    var docTypes: [FilterDocTypeModel] = [.init(docType: .type1),
                                          .init(docType: .type2),
                                          .init(docType: .type3),
                                          .init(docType: .type4),
                                          .init(docType: .type5),
                                          .init(docType: .type6),
                                          .init(docType: .type7),
                                          .init(docType: .type8),
                                          .init(docType: .type9),
                                          .init(docType: .type10),
                                          .init(docType: .type11),
                                          .init(docType: .type12)]
    
    var selectedDocTypes: [FilterDocTypeModel] = []
    
    var delegate: DocTypeViewControllerProtocol?
    
    private var selectedCount: Int = 0
    
    private lazy var backIconImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.backButtonIcon.name), for: .normal)
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let selectedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.delegate = self
        
        return searchBar
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        view.register(cellClass: FilterDocTypeViewCell.self)
        return view
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.88, green: 0.381, blue: 0.229, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(applyButtonDidTap), for: .touchUpInside)
        return button
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        view.backgroundColor = .white
        setup()
    }


    // MARK: DocTypeViewInput
    func setupInitialState() {
    }
    
    @objc private func applyButtonDidTap() {
        delegate?.didSelectDocType(docTypes.sorted(by: {$0.isSelected && !$1.isSelected}))
        output?.dismiss()
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [mainTableView,
         backIconImageView,
         clearButton,
         selectedLabel,
         titleLabel,
         searchBar,
         applyButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.centerX.equalToSuperview()
        }
        
        selectedLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
        
        backIconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalToSuperview().offset(16)
        }
        
        clearButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(34)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(16)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(docTypes.count * 64)
        }
        
        applyButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func closeVC() {
        dismiss(animated: true)
    }
    
    @objc
    private func clearTapped() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        selectedCount = 0
        selectedLabel.text = "Selected: 0"
        docTypes.indices.forEach { index in
            docTypes[index].isSelected = false
        }
        clearButton.setTitleColor(.gray, for: .normal)
        self.mainTableView.reloadData()
    }
}

extension DocTypeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.mainTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.mainTableView.reloadData()
    }
}

extension DocTypeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = docTypes[indexPath.row]
        
        let cell: FilterDocTypeViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: model)
        return cell
    }
}

extension DocTypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        docTypes[indexPath.row].isSelected.toggle()
        selectedDocTypes = docTypes.filter({$0.isSelected == true})
        selectedCount = selectedDocTypes.count
        selectedLabel.text = "Selected: \(selectedCount)"
        
        clearButton.setTitleColor(selectedDocTypes.isEmpty ? .gray : UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1), for: .normal)
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
