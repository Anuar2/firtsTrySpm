//
//  SearchViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class SearchViewController: UIViewController, SearchViewInput {
    
    var presenter: SearchPresenterInput?
    
    //MARK: - Properties
    var docCategories: [SearchCategory] = [.init(tab: .all, isSelected: true),
                                           .init(tab: .inbox),
                                           .init(tab: .sent),
                                           .init(tab: .draft)]
    
    var selectedCatgory: SearchCategory = .init(tab: .all)
    var filteredDocumentList: DocumentsViewModel = []
    
    //MARK: - View
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var sliderView: UIView = {
        let view = UIView()
        view.alpha = 0.24
        view.layer.backgroundColor = DFColor.lightSecondary
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var backIconImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.backButtonIcon.name), for: .normal)
        button.addTarget(self, action: #selector(backButtonPress), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var navigationTitleLabel: UIView = {
        let label = UILabel()
        label.text = "Search"
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Medium", size: 16)
        return label
    }()
    
    private lazy var searchTextField: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.delegate = self
        return bar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(cellClass: SearchCollectionViewCell.self)
        return view
    }()
    
    lazy var documentListTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.register(cellClass: DocumentListTableViewCell.self)
        return view
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.output = self
        presenter?.userChangedTab(to: docCategories.first?.tab.rawValue ?? String())
        presenter?.viewIsReady()
        view.backgroundColor = DFColor.lighBackground
        
        setup()
    }
    
    
    // MARK: SearchViewInput
    func setupInitialState() {
    }
    
    //MARK: - Methods
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [topView, documentListTableView].forEach {
            view.addSubview($0)
        }
        
        [sliderView, backIconImageView, navigationTitleLabel, searchTextField, collectionView].forEach {
            topView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/5)
        }
        
        sliderView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(4)
        }
        
        backIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        navigationTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        searchTextField.snp.makeConstraints {make in
            make.top.equalTo(navigationTitleLabel.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        documentListTableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func backButtonPress() {
        presenter?.dissmiss()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterDocumentsBy(searchText)
    }
}

extension SearchViewController: SearchPresenterOutput {
    func presentResult(_ viewmodel: DocumentsViewModel) {
        self.filteredDocumentList = viewmodel
        self.documentListTableView.reloadData()
    }
}
