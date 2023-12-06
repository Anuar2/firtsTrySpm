//
//  FilterFilterViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import SnapKit

protocol FilterViewControllerDelegate {
    func applyButtonDidTap(_ filter: FilterDocumentListModel)
    func resultFilter(document: DocumentsViewModel)
}

class FilterViewController: UIViewController, FilterViewInput {
    
    //MARK: - Properties
    var presenter: FilterPresenterInputProtocol?
    
    var delegate: FilterViewControllerDelegate?
    
    let sections: [FilterSection] = [.init(section: .main, rows: [.docType,
                                                                .docStatus,
                                                                .initiator,
                                                                .lastModified,
                                                                .creationDate,
                                                                .expiryDate])]
    
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
    
    var docStatuses: [FilterDocStatusModel] = [.init(docStatus: .draft),
                                               .init(docStatus: .onSigning),
                                               .init(docStatus: .signed)]
    
    var initiators: [FilterInitiatorModel] = []
    var date: [String] = []
    var expireDate: [String] = []
    var lastModifiedDate: [String] = []
    var isSelectedType = false
    var filterDocument: FilterDocumentListModel? = FilterDocumentListModel(statuses: ["DRAFT"], initiatorIDS: [], updatedAtStart: "", updatedAtEnd: "", createdAtStart: "", createdAtEnd: "", expiredDateStart: "", expiredDateEnd: "", sortBy: "TITLE", sortDir: "ASC", term: "", page: 1, size: 25)
    
    //MARK: - View
    
    private lazy var navBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backIconImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.backButtonIcon.name), for: .normal)
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filters"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
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
        view.backgroundColor = DFColor.lighBackground
        view.rowHeight = UITableView.automaticDimension
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var sepatatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.opacity = 0.5
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
    
    @objc private func applyButtonDidTap() {
        guard let filterDocument = filterDocument else {return}
        presenter?.requestDocuments(q: filterDocument)
        delegate?.applyButtonDidTap(filterDocument)
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.output = self
        presenter?.viewIsReady()
            
        view.backgroundColor = DFColor.lighBackground
        setup()
    }
    
    
    // MARK: FilterViewInput
    func setupInitialState() {
    }
    
    //MARK: - Methods
    private func setup() {
        setupNavigation()
        setupViews()
        makeConstraints()
        
        if isSelectedType {
            clearButton.setTitleColor(.orange, for: .normal)
        }
    }
    
    private func setupNavigation() {
        navigationController?.title = "Filters"
    }
    
    private func setupViews() {
        [
            DefaultCell.self,
            DocTypeCell.self,
            DocStatusCell.self,
            InitiatorStatusCell.self,
            CreationDateCell.self
        ].forEach {
            mainTableView.register(cellClass: $0)
        }
        
        [backIconImageView, titleLabel, clearButton].forEach {
            navBarView.addSubview($0)
        }
        [
            navBarView,
            mainTableView,
            sepatatorView,
            applyButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        navBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(68)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
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
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(navBarView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        sepatatorView.snp.makeConstraints { make in
            make.top.equalTo(mainTableView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        applyButton.snp.makeConstraints { make in
            make.top.equalTo(sepatatorView.snp.bottom).offset(8)
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
        
        initiators = []
        date = []
        expireDate = []
        lastModifiedDate = []
        docStatuses = [.init(docStatus: .draft),
                       .init(docStatus: .onSigning),
                       .init(docStatus: .signed),]
        
        docTypes = [.init(docType: .type1),
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
        clearButton.setTitleColor(.gray, for: .normal)
        mainTableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        switch row {
        case .docType:
            let cell: DocTypeCell = tableView.dequeueReusableCell(for: indexPath)
            cell.docTypes = docTypes
            cell.configure(title: "Type", docTypes: docTypes)
            cell.onReceiveDataCallback = { [weak self] in
                self?.mainTableView.beginUpdates()
                self?.mainTableView.endUpdates()
            }
            
            return cell
        case .docStatus:
            let cell: DocStatusCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Status", docStatuses: docStatuses)
            cell.onReceiveDataCallback = { docStatuses in
                self.filterDocument?.statuses = docStatuses.filter({$0.isSelected == true}).map({$0.docStatus.rawValue})
                
                let selectedDocStatuses = docStatuses.filter { $0.isSelected }.map { $0.docStatus.rawValue }
                self.filterDocument?.statuses = selectedDocStatuses
                self.mainTableView.beginUpdates()
                self.mainTableView.endUpdates()
            }
            return cell
        case .initiator:
            let cell: InitiatorStatusCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Initiator", selectedInitiators: initiators)
            cell.onReceiveDataCallback = { [weak self] in
                self?.mainTableView.beginUpdates()
                self?.mainTableView.endUpdates()
            }

            return cell
        case .lastModified:
            let cell: CreationDateCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Last modified", date: lastModifiedDate)
            cell.onReceiveDataCallback = { [weak self] in
                self?.mainTableView.beginUpdates()
                self?.mainTableView.endUpdates()
            }

            return cell
        case .creationDate:
            let cell: CreationDateCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Start date", date: date)
            cell.onReceiveDataCallback = { [weak self] in
                self?.mainTableView.beginUpdates()
                self?.mainTableView.endUpdates()
            }
            return cell
        case .expiryDate:
            let cell: CreationDateCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Expiry date", date: expireDate)
            cell.onReceiveDataCallback = { [weak self] in
                self?.mainTableView.beginUpdates()
                self?.mainTableView.endUpdates()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        switch row {
        case .docType:
            presenter?.presentDocTypeView()
        case .initiator:
            presenter?.presentFilterInitiatorView()
        case .creationDate:
            presenter?.presentCreationDateView()
        case .expiryDate:
            presenter?.presentExpireDateView()
        case .lastModified:
            presenter?.presentLastModifitedView()
        default:
            break
        }
    }
}

extension FilterViewController: DocTypeViewControllerProtocol {
    func didSelectDocType(_ selectedDocTypes: [FilterDocTypeModel]) {
        if docTypes.allSatisfy({ $0.isSelected }) {
            clearButton.setTitleColor(UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1), for: .normal)
        }
        
        docTypes = selectedDocTypes
//        filterDocument?.typeID = docTypes.filter({$0.isSelected == true}).map({$0.docType.rawValue})
        let indexPath = IndexPath(row: 0, section: 0)
    
        mainTableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension FilterViewController: InitiatorViewControllerProtocol {
    func didSelectInitiator(_ selectedInitiators: [FilterInitiatorModel]) {
        clearButton.setTitleColor(UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1), for: .normal)
        
        initiators = selectedInitiators
        
        let indexPath = IndexPath(row: 2, section: 0)
        filterDocument?.initiatorIDS = initiators.filter({$0.isSelected == true}).map({$0.id ?? ""})
        mainTableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension FilterViewController: LastModifiedDateViewControllerDelegate {
    func didSelectLastModifiedDateRange(dateFrom: String, dateTo: String) {
        if let formattedStartDate = convertDateString(dateFrom),
           let formattedEndDate = convertDateString(dateTo) {
            
            let dateRange = "\(formattedStartDate) - \(formattedEndDate)"
            self.lastModifiedDate = [dateRange]
            clearButton.setTitleColor(UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1), for: .normal)
            
            let indexPath = IndexPath(row: 3, section: 0)
            filterDocument?.updatedAtStart = formattedStartDate
            filterDocument?.updatedAtEnd = formattedEndDate
            mainTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}


extension FilterViewController: CreationDateViewControllerDelegate {
    func didSelectDateRange(dateFrom: String, dateTo: String) {
        if let formattedStartDate = convertDateString(dateFrom),
           let formattedEndDate = convertDateString(dateTo) {
            
            let dateRange = "\(formattedStartDate) - \(formattedEndDate)"
            self.date = [dateRange]
            clearButton.setTitleColor(UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1), for: .normal)
            
            let indexPath = IndexPath(row: 4, section: 0)
            filterDocument?.createdAtStart = formattedStartDate
            filterDocument?.createdAtEnd = formattedEndDate
            
            mainTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension FilterViewController: ExpireDateViewControllerDelegate {
    func didSelectExpireDateRange(dateFrom: String, dateTo: String) {
        if let formattedStartDate = convertDateString(dateFrom),
           let formattedEndDate = convertDateString(dateTo) {
            
            let dateRange = "\(formattedStartDate) - \(formattedEndDate)"
            self.expireDate = [dateRange]
            clearButton.setTitleColor(UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1), for: .normal)
            
            let indexPath = IndexPath(row: 5, section: 0)
            filterDocument?.expiredDateStart = formattedStartDate
            filterDocument?.expiredDateEnd = formattedEndDate
            
            mainTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension FilterViewController {
    func convertDateString(_ dateString: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "MMM d, yyyy"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatterInput.date(from: dateString) {
            return dateFormatterOutput.string(from: date)
        }
        
        return nil
    }
}

extension FilterViewController: FilterPresenterProtocol {
    func presentViewModel(document: DocumentsViewModel) {
        delegate?.resultFilter(document: document)
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.dissmiss()
        }
    }
}
