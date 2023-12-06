//
//  EditDocumentInfoViewController.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

enum EditDocumentInfoModules: String {
    case details = "Details"
    case preview = "Preview"
}

class EditDocumentInfoViewController: UIViewController {

    var presenter: EditDocumentInfoPresenterInputProtocol?
    
    let sections: [Sections] = [.init(section: .main, rows: [.detail, .preview])]
    
    var documentInfo: DocumentViewModel? {
        didSet {
            mainView.reloadData()
        }
    }
    
    var pdfData: Data? {
        didSet {
            mainView.reloadData()
        }
    }
    
    var documentURL: URL? {
        didSet {
            mainView.reloadData()
        }
    }
    //MARK: - View
    private lazy var navigationView: DFFloatingPanelNavBar = {
        let view = DFFloatingPanelNavBar()
        view.navigationTitle = "Edit document Info"
        view.dissmiss = { [weak self] in
            self?.presenter?.dissmiss()
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
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save & Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.88, green: 0.381, blue: 0.229, alpha: 1)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        view.register(cellClass: DocumentDetailView.self)
        view.register(cellClass: PreviewView.self)
        return view
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let initialIndex = 1
        mainView.scrollToItem(at: IndexPath(item: initialIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        presenter?.output = self
        presenter?.viewIsReady()
        view.backgroundColor = DFColor.lighBackground
        setup()
        
        tabsView.selectItem(at: 1)
        
        let initialIndex = 1
        mainView.scrollToItem(at: IndexPath(item: initialIndex, section: 0), at: .centeredHorizontally, animated: false)
    }

    init(pdfData: Data? = nil, documentURL: URL?) {
        super.init(nibName: nil, bundle: nil)
        self.pdfData = pdfData
        self.documentURL = documentURL
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    @objc func addInitiatorsDidTap() {
        presenter?.presentInitiatorView()
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [navigationView,
         tabsView,
         mainView,
         backButton,
         createButton].forEach {
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
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tabsView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(167)
            make.height.equalTo(40)
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(167)
            make.height.equalTo(40)
        }
    }
    
    @objc func backButtonTapped() {
        presenter?.dissmiss()
    }
    
    @objc private func createButtonDidTap() {
        if documentInfo?.initiatorFullname == nil {
            guard let popUpVC = presenter?.presentPopUpEmptyInitiator() as? EmptyInitiatorAlertViewController else { return }
            popUpVC.delegate = self
        } else {
            presenter?.userDidTappedOnPublish()
        }
    }
}

extension EditDocumentInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .detail:
            let cell: DocumentDetailView = collectionView.dequeueReusableCell(for: indexPath)
            cell.signatoriesList = documentInfo?.signatories ?? [
                .init(id: "0", firstName: "Abdinur", lastName: "Kuatbek"),
                .init(id: "1", firstName: "Anuar", lastName: "Orazbekov")
            ]
            cell.documentInfo = self.documentInfo
            return cell
        case .preview:
            let cell: PreviewView = collectionView.dequeueReusableCell(for: indexPath)
            cell.signatoriesList = documentInfo?.signatories ?? [
                .init(id: "0", firstName: "Abdinur", lastName: "Kuatbek"),
                .init(id: "1", firstName: "Anuar", lastName: "Orazbekov")
            ]
            cell.pdfData = self.pdfData
            cell.documentURL = self.documentURL
            cell.onAddSignatoriesDidTap = {
                self.addInitiatorsDidTap()
                self.mainView.reloadData()
            }
            return cell
        }
    }
}

extension EditDocumentInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

extension EditDocumentInfoViewController: InitiatorViewControllerProtocol {
    // TODO: - Переписать логику. Инициатор - это создатель документа
    func didSelectInitiator(_ selectedInitiators: [FilterInitiatorModel]) {
        documentInfo?.signatories = selectedInitiators
    }
}

extension EditDocumentInfoViewController: TabsViewViewDelegate {
    func didTap(at index: Int) {
        mainView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension EditDocumentInfoViewController {
    struct Sections {
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

extension EditDocumentInfoViewController: PublishedDocumentAlertDelegate {
    func saveDocumentToHome() {
        self.presenter?.dissmiss()
    }
}

extension EditDocumentInfoViewController: FullPublishedDocumentAlertDelegate {
    func sendDocumentToHome() {
        self.presenter?.dissmiss()
    }
}

extension EditDocumentInfoViewController: EmptyInitiatorAlertDelegate {
    func saveAsDraft() {
        print("")
    }
}

// MARK: - Presenter
extension EditDocumentInfoViewController: EditDocumentInfoPresenterOutputProtocol {
    func presentPublishResult(_ result: Bool) {
        switch result {
        case true:
            guard let popUpVC = presenter?.presentPopUpFull() as? FullPublishedDocumentAlertViewController else { return }
            popUpVC.delegate = self
        case false:
            guard let popUpVC = presenter?.presentPopUp() as? PublishedDocumentAlertViewController else { return }
            popUpVC.delegate = self
        }
    }
    
    func presentViewModel(_ viewmodel: DocumentViewModel) {
        documentInfo = viewmodel
    }
}
