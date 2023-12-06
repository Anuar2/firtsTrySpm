//
//  AdDocumentViewController.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol AdDocumentViewDelegate {
    func saveAndCancelButtonDidTap()
}

class AdDocumentViewController: UIViewController {

    var presenter: AdDocumentPresenterInputProtocol?
    
    var delegate: AdDocumentViewDelegate?
    
    let sections: [AdDocumentSection] = [.init(section: .main, rows: [.detail, .preview])]
    
    var document: DocumentViewModel?
    
    var documentLink: String?
    
    //MARK: - View
    private lazy var navigationView: DFFloatingPanelNavBar = {
        let view = DFFloatingPanelNavBar()
        view.navigationTitle = "Document Info"
        view.rightBarButtonIcon = Assets.adActionIcon.name
        view.dissmiss = { [weak self] in
            self?.presenter?.dissmiss()
        }
        view.rightBarButtonAction = { [weak self] in
            guard let document = self?.document else { return }
            self?.presenter?.documentActions(documentViewModel: document)
        }
        return view
    }()
    
    private lazy var tabsView: TabsView = {
        let view = TabsView(items: [
            EditDocumentInfoModules.details.rawValue,
            EditDocumentInfoModules.preview.rawValue
        ])
        view.delegate = self
        return view
    }()
    
    private lazy var mainView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isScrollEnabled = false
        view.register(cellClass: AdDocumentDetailCell.self)
        view.register(cellClass: PreviewView.self)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "editRegular"), for: .normal)
        button.addTarget(self, action: #selector(editButtonDidTap), for: .touchUpInside)
        
        button.layer.borderWidth = 0.5
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DFColor.lighBackground
        presenter?.output = self
        presenter?.viewIsReady()
        setup()
    }
    
    
    // MARK: - Methods
    @objc internal func editButtonDidTap() {
        guard let document = document else { return }
        presenter?.documentActions(documentViewModel: document)
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
        tabsView.topDividerView.isHidden = true
    }
    
    private func setupViews() {
        [navigationView,
         tabsView,
         mainView,
         editButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(tabsView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(editButton.snp.top).inset(-16)
        }
        
        tabsView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(48)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
}

// MARK: - Presenter
extension AdDocumentViewController: AdDocumentPresenterOutputProtocol {
    func presentAttachmentLink(link: String) {
        documentLink = link
        document?.documentLink = link
        mainView.reloadData()
    }
    
    func presentViewModel(_ viewmodel: DocumentViewModel) {
        document = viewmodel
        mainView.reloadData()
    }
}

extension AdDocumentViewController: TabsViewViewDelegate {
    func didTap(at index: Int) {
        mainView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension AdDocumentViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return document != nil ? sections[section].rows.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = document else {
            return UICollectionViewCell()
        }
        
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .detail:
            let cell: AdDocumentDetailCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: model)
            return cell
        case .preview:
            let cell: PreviewView = collectionView.dequeueReusableCell(for: indexPath)
            cell.signatoriesList = [
                .init(id: "0", firstName: "Abdinur", lastName: "Kuatbek"),
                .init(id: "1", firstName: "Anuar", lastName: "Orazbekov")
            ]
            if let documentLink = documentLink {
                cell.documentURL = URL(string: documentLink)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.bounds.width, height: mainView.bounds.height)
    }
}

extension AdDocumentViewController {
    struct AdDocumentSection {
        enum Section {
            case main
        }
        
        enum Row {
            case detail
            case preview
        }
        
        let section: Section
        var rows: [Row]
    }
}

extension AdDocumentViewController: DocumentActionsViewDelegate {
    func saveAndCancelButtonDidTap() {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.dissmiss()
            self?.delegate?.saveAndCancelButtonDidTap()
        }
    }
}
