//
//  DocumentListViewController.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import SnapKit
import PDFKit

protocol DocumentListViewProtocol: AnyObject {
    func updateFilesData(_ documentList: [DocumentAdModel])
}

public class DocumentListViewController: UIViewController {
    //MARK: - Properties
    var presenter: DocumentListPresenterInputProtocol?
    
    var documentList: DocumentsViewModel = [] {
        didSet {
            documentEmptyView.isHidden = documentList.isEmpty ? false : true
            pickFileButton.isHidden = documentList.isEmpty ? false : true
            documentListTableView.isHidden = documentList.isEmpty ? true : false
        }
    }
    
    lazy var tabsView: TabsView = {
        let view = TabsView(items: [
            DocumentTab.inbox.rawValue,
            DocumentTab.sent.rawValue,
            DocumentTab.all.rawValue,
            DocumentTab.draft.rawValue
        ])
        view.delegate = self
        return view
    }()
    
    var selectedFileDatas: [Data?] = []
    
    var selectedFileData: Data?
    
    private var selectedTab: String = ""
    
    var filterDocument: FilterDocumentListModel? = FilterDocumentListModel(statuses: ["DRAFT"], initiatorIDS: [], updatedAtStart: "", updatedAtEnd: "", createdAtStart: "", createdAtEnd: "", expiredDateStart: "", expiredDateEnd: "", sortBy: "TITLE", sortDir: "ASC", term: "", page: 1, size: 25)
    
    //MARK: - View
    
    private let refresher: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Reload documents")
        control.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return control
    }()
    
    private lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = DFColor.lightTertiary
        return view
    }()
    
    private lazy var documentListTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.register(cellClass: DocumentListTableViewCell.self)
        view.isHidden = documentList.isEmpty ? true : false
        view.refreshControl = refresher
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var documentEmptyView: EmptyTableView = {
        let view = EmptyTableView()
        view.isHidden = documentList.isEmpty ? false : true
        return view
    }()
    
    private lazy var pickFileButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Document", for: .normal)
        button.titleLabel?.font = UIFont(name: "EuclidCircularB-Medium", size: 14)
        button.layer.backgroundColor = UIColor(red: 0.88, green: 0.381, blue: 0.229, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.isHidden = documentList.isEmpty ? false : true
        button.addTarget(self, action: #selector(showPickPDFFileViewButtonDIdTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var addDocumentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.addDocumentButton.name), for: .normal)
        button.addTarget(self, action: #selector(showPickPDFFileViewButtonDIdTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.output = self
        presenter?.getEmployes(q: "655b7bfb-ff67-4a81-a48f-89c054f188b7")
        presenter?.userChangedTab(to: tabsView.items.first ?? String())
        refresher.beginRefreshing()

        presenter?.requestInitialDocuments()

        view.backgroundColor = DFColor.lighBackground
        setup()
    }
    
    //MARK: - Mothods
    @objc private func showPickPDFFileViewButtonDIdTap() {
        guard let uploadAlertVC = presenter?.userDidSelectFile() as? UploadDocumentViewController else { return }
        uploadAlertVC.delegate = self
    }
    
    @objc private func showPDFFileViewButtonDIdTap() {
        if selectedFileData != nil {
            presenter?.userDidSelectPDFFIle(with: selectedFileData)
        }
    }
    
    @objc func filterButtonDidTap() {
        presenter?.filterButtonDidTap()
    }
    
    @objc func searchButtonDidTap() {
        presenter?.searchButtonDidTap()
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        guard !selectedTab.isEmpty else {
              refresher.endRefreshing()
              return
          }

          presenter?.userChangedTab(to: selectedTab)
          presenter?.requestInitialDocuments()
    }
    
    private func setup() {
        setupNavigation()
        setupViews()
        makeConstraints()
    }
    
    private func setupNavigation() {
        lazy var filterButton = UIBarButtonItem(image: UIImage(named: Assets.filterIcon.name) , style: .plain, target: self, action: #selector(filterButtonDidTap))
        filterButton.tintColor = .white
        
        let searchButton = UIBarButtonItem(image: UIImage(named: Assets.searchIcon.name) , style: .plain, target: self, action: #selector(searchButtonDidTap))
        searchButton.tintColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Documents"
        titleLabel.textColor = .white
        let titleBarBUtton = UIBarButtonItem(customView: titleLabel)
        
        let iconImageView = UIImageView()
        iconImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        iconImageView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        iconImageView.layer.cornerRadius = 8
        iconImageView.image = UIImage(named: Assets.documentIcon.name)
        iconImageView.contentMode = .scaleAspectFit
        let iconImageBarBUtton = UIBarButtonItem(customView: iconImageView)
        
        navigationItem.setLeftBarButtonItems([iconImageBarBUtton,titleBarBUtton], animated: true)
        self.navigationItem.setRightBarButtonItems([searchButton, filterButton], animated: true)
        self.navigationController?.navigationBar.backgroundColor = DFColor.lightTertiary
    }
    
    private func setupViews() {
        [navigationView,
         tabsView,
         documentListTableView,
         documentEmptyView,
         pickFileButton,
         addDocumentButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabsView.snp.top)
        }
        
        tabsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        documentListTableView.snp.makeConstraints { make in
            make.top.equalTo(tabsView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        documentEmptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        pickFileButton.snp.makeConstraints { make in
            make.top.equalTo(documentEmptyView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(129)
            make.height.equalTo(40)
        }
        
        addDocumentButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(68)
            make.size.equalTo(96)
        }
    }
}

//MARK: - UIDocumentPickerDelegate
extension DocumentListViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedURL = urls.first else { return }
        
        urls.forEach { url in
            do {
                selectedFileData = try Data(contentsOf: url)
                selectedFileDatas.append(selectedFileData)
            } catch {
                print("Error reading file: \(error)")
            }
        }
        
        do {
            selectedFileData = try Data(contentsOf: selectedURL)
            if let selectedFileData = selectedFileData {
                if let _ = getTitleFromPDF(pdfData: selectedFileData) {
//                    documentInfoView.setTitle(title, for: .normal)
                }
            }
        } catch {
            print("Error reading file: \(error)")
        }
    }
}

extension DocumentListViewController: DocumentListViewProtocol {
    func updateFilesData(_ documentList: [DocumentAdModel]) {
        self.documentEmptyView = documentEmptyView
    }
}


extension DocumentListViewController {
    func getTitleFromPDF(pdfData: Data) -> String? {
        if let pdfDocument = PDFDocument(data: pdfData),
           let metadata = pdfDocument.documentAttributes,
           let title = metadata[PDFDocumentAttribute.titleAttribute] as? String {
            return title
        }
        return nil
    }
}


extension DocumentListViewController: TabsViewViewDelegate {
    func didTap(at index: Int) {
        selectedTab = tabsView.items[index]
        presenter?.userChangedTab(to: tabsView.items[index])
    }
}

// MARK: - UploadDocumentVCDelegate
extension DocumentListViewController: UploadDocumentVCDelegate {
    func createDocument(with file: Data?, documentURL: URL?) {
        presenter?.presentCreateDocFlow(with: file, documentURL: documentURL)
    }
}

// MARK: - PresenterDelegate
extension DocumentListViewController: DocumentListPresenterOutputProtocol {
    func documents(_ viewmodel: DocumentsViewModel) {
        documentList = viewmodel
        documentListTableView.reloadData()
        refresher.endRefreshing()
    }
}

extension DocumentListViewController: FilterViewControllerDelegate {
    func resultFilter(document: DocumentsViewModel) {
        
        DispatchQueue.main.async {
            self.documentList = document
            self.documentListTableView.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
    func applyButtonDidTap(_ filter: FilterDocumentListModel) {
        filterDocument = filter
    }
}

extension DocumentListViewController: AdDocumentViewDelegate {
    func saveAndCancelButtonDidTap() {
        DispatchQueue.main.async { [weak self] in
            self?.documentListTableView.reloadData()
            self?.refresher.endRefreshing()
            self?.presenter?.dissmiss()
        }
    }
}

