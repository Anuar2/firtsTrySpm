//
//  EditAdDocumentInfoViewController.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol EditAdDocumentInfoViewDelegate {
    func saveAndCancelBtttonDidTap()
}

class EditAdDocumentInfoViewController: UIViewController {

    var presenter: EditAdDocumentInfoPresenterInputProtocol?
    
    var delegate: EditAdDocumentInfoViewDelegate?
    
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
        view.register(cellClass: EditAdDocumentInfoCell.self)
        view.register(cellClass: PreviewView.self)
        return view
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        presenter?.output = self
        presenter?.viewIsReady()
        view.backgroundColor = DFColor.lighBackground
        setup()
        tabsView.selectItem(at: 0)
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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(backButton.snp.top).offset(-8)
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
        self.presenter?.dissmiss()
        DispatchQueue.main.async {
            self.delegate?.saveAndCancelBtttonDidTap()
        }
        presenter?.updateDocument()
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

extension EditAdDocumentInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .detail:
            let cell: EditAdDocumentInfoCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.signatoriesList = presenter?.adDocumentInfo?.signatories ?? []
            cell.documentInfo = self.documentInfo
            cell.onPickButtonDidTap = {
                self.presenter?.presentDocumentPickerView()
            }
            cell.onDocumentChanged = { documentInfo in
                self.presenter?.adDocumentInfo = documentInfo
                self.documentInfo = documentInfo
            }
            cell.onInitiatorsDidTap = {
                self.presenter?.presentInitiatorView()
            }
            cell.onStartDateDidTap = {
                self.presenter?.presentStartDateView()
            }
            cell.onEndDateDidTap = {
                self.presenter?.presentEndDateView()
            }
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

extension EditAdDocumentInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

extension EditAdDocumentInfoViewController: InitiatorViewControllerProtocol {
    // TODO: - Переписать логику. Инициатор - это создатель документа
    func didSelectInitiator(_ selectedInitiators: [FilterInitiatorModel]) {
        documentInfo?.signatories = selectedInitiators
        presenter?.adDocumentInfo?.signatories = selectedInitiators
    }
}

extension EditAdDocumentInfoViewController: TabsViewViewDelegate {
    func didTap(at index: Int) {
        mainView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension EditAdDocumentInfoViewController {
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

extension EditAdDocumentInfoViewController: PublishedDocumentAlertDelegate {
    func saveDocumentToHome() {
        self.presenter?.dissmiss()
    }
}

extension EditAdDocumentInfoViewController: FullPublishedDocumentAlertDelegate {
    func sendDocumentToHome() {
        self.presenter?.dissmiss()
    }
}

extension EditAdDocumentInfoViewController: EmptyInitiatorAlertDelegate {
    func saveAsDraft() {
        print("")
    }
}

extension EditAdDocumentInfoViewController: StartDateCalendarViewDelegate {
    func didPickDate(_ dateString: String) {
        documentInfo?.startDate = dateString
        presenter?.adDocumentInfo?.startDate = dateString
    }
}

extension EditAdDocumentInfoViewController: EndDateCalendarViewDelegate {
    func didEndPickDate(_ dateString: String) {
        documentInfo?.endDate = dateString
        presenter?.adDocumentInfo?.endDate = dateString
    }
}

// MARK: - Presenter
extension EditAdDocumentInfoViewController: EditAdDocumentInfoPresenterOutputProtocol {
    func presentAttachmentModel(_ model: AttachmentModel) {
        documentInfo?.documentLink = model.link
        documentURL = URL(string: model.link ?? "")
    }
    
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

extension EditAdDocumentInfoViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedURL = urls.first else { return }
        
        let fileExtension = selectedURL.pathExtension

        do {
            if !selectedURL.lastPathComponent.isEmpty {
                self.presenter?.adDocumentInfo?.documentLink = "\(selectedURL)"
                self.documentInfo?.documentLink = "\(selectedURL)"
                self.documentURL = selectedURL
                mainView.reloadData()
            }
        } catch {
            print("Error reading file: \(error)")
        }
    }
}
