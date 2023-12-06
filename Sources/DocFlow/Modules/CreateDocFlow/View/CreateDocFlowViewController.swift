//
//  CreateDocFlowViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import SnapKit

class CreateDocFlowViewController: UIViewController {
    
    var presenter: CreateDocFlowPresenterInputProtocol?
    
    var pdfData: Data?
    var startDateText: String?
    var endDateText: String?
    var isInputValid: Bool = false
    var documentURL: URL?
    
    let sections: [CreateDocFlowSection] = [.init(section: .main, rows: [.docNumber, .docName, .docType, .signType, .signatories, .docDescription, .calendar])]
    
    var activeIndexPath: IndexPath?
    
    var createButtonTapped: Bool = false
    
    private var docTypes: [FilterDocTypeModel] = [.init(docType: .type1), .init(docType: .type1)]
    private var signatoriesList = [FilterInitiatorModel]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DFColor.lighBackground
        setup()
        observerKeyboard()
        presenter?.output = self
    }
    
    //MARK: - View
    private lazy var navigationView: DFFloatingPanelNavBar = {
        let view = DFFloatingPanelNavBar()
        view.navigationTitle = "Enter document info"
        view.dissmiss = { [weak self] in
            self?.presenter?.dissmiss()
        }
        return view
    }()
    
    private lazy var mainTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
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
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createButtonDidTap), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc private func createButtonDidTap() {
        createButtonTapped = true
        mainTableView.reloadData()
        guard let popUpVC = presenter?.presentPopUp() as? SaveDocumentAlertViewController else { return }
        popUpVC.delegate = self
    }
    
    private func presentStartDateCalendarView() {
        presenter?.presentStartDateCalendarView()
    }
    
    private func presentEndDateCalendarView() {
        presenter?.presentEndDateCalendarView()
    }
    
    private func setup() {
        setupNavigation()
        setupViews()
        makeConstraints()
    }
    
    private func observerKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mainTableView.addGestureRecognizer(tapGesture)
    }
    
    func setupInitialState() { }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupViews() {
        [
            BaseDocCell.self,
            SignTypeCell.self,
            SignaturesCell.self,
            CreateDocCalendarCell.self
        ].forEach {
            mainTableView.register(cellClass: $0)
        }
        
        [navigationView,
         mainTableView,
         backButton,
         createButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupNavigation() {
        navigationController?.title = "Enter document info"
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(68)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(backButton.snp.top).inset(-10)
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            mainTableView.contentInset = contentInsets
            mainTableView.scrollIndicatorInsets = contentInsets

            if let activeIndexPath = activeIndexPath {
                mainTableView.scrollToRow(at: activeIndexPath, at: .none, animated: true)
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        mainTableView.contentInset = .zero
        mainTableView.scrollIndicatorInsets = .zero
    }
}

extension CreateDocFlowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        let isCellInFocus = indexPath == activeIndexPath
        
        switch row {
        case .docNumber:
            let model = BaseDocCellModel(
                isOnFocus: isCellInFocus,
                placeHolder: "Document number",
                editingPlaceholder: "Enter document number",
                image: UIImage(named: Assets.documentNumberIcon.name),
                title: "Document number")
            
            let cell: BaseDocCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textChanged = { [weak self] text in
                self?.presenter?.docNumber = text
            }
            cell.createButtonDidTap = createButtonTapped
            cell.configure(with: model)
            return cell
        case .docName:
            let model = BaseDocCellModel(
                isOnFocus: isCellInFocus,
                placeHolder: "Document name",
                editingPlaceholder: "Enter document name",
                image: UIImage(named: Assets.documentNameIcon.name),
                title: "Document name")
            
            let cell: BaseDocCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textChanged = { text in
                self.presenter?.docName = text
            }
            cell.createButtonDidTap = createButtonTapped
            cell.textField.text = presenter?.docName
            cell.configure(with: model)
            
            return cell
        case .docType:
            let model = BaseDocCellModel(
                isOnFocus: isCellInFocus,
                placeHolder: "Document type",
                editingPlaceholder: "Enter document type",
                image: UIImage(named: Assets.agreementIcon.name),
                title: "Document type")
            let cell: BaseDocCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textChanged = { text in
                self.presenter?.docTypeText = text
            }
            cell.createButtonDidTap = createButtonTapped
            cell.configure(with: model)
            
            return cell
        case .signType:
            let cell: SignTypeCell = tableView.dequeueReusableCell(for: indexPath)
            
            return cell
        case .docDescription:
            let model = BaseDocCellModel(
                isOnFocus: isCellInFocus,
                placeHolder: "Description",
                editingPlaceholder: "Enter description",
                image: UIImage(named: Assets.descriptionIcon.name),
                title: "Description")
            
            let cell: BaseDocCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textChanged = { text in
                self.presenter?.docDescription = text
            }
            cell.createButtonDidTap = createButtonTapped
            cell.configure(with: model)
            
            cell.textField.text = presenter?.docDescription
            return cell
        case .signatories:
            let cell: SignaturesCell = tableView.dequeueReusableCell(for: indexPath)
            cell.signatureTapped = { [weak self] in
                self?.presenter?.presentSignatoriesView()
            }
            cell.onReceiveDataCallback = {
                self.mainTableView.beginUpdates()
                self.mainTableView.endUpdates()
            }
            cell.callBackRecieve(signaturesList: signatoriesList)
            
            return cell
        case .calendar:
            let cell: CreateDocCalendarCell = tableView.dequeueReusableCell(for: indexPath)
            cell.onStartDateButtonDidTap = {
                self.presentStartDateCalendarView()
            }
            cell.onEndDateButtonDidTap = {
                self.presentEndDateCalendarView()
            }
            cell.configure(starteDateTitle: presenter?.startDate ?? "", endDateTitle: presenter?.endDate ?? "")
            return cell
        }
    }
    
    @objc func backButtonTapped() {
        presenter?.dissmiss()
    }
}

extension CreateDocFlowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        default:
            activeIndexPath = indexPath
        }
        mainTableView.reloadData()
    }
}


extension CreateDocFlowViewController: DocTypeViewControllerProtocol {
    func didSelectDocType(_ selectedDocTypes: [FilterDocTypeModel]) {
        self.docTypes = selectedDocTypes.sorted(by: {$0.isSelected && !$1.isSelected})
        mainTableView.reloadData()
    }
}

extension CreateDocFlowViewController: InitiatorViewControllerProtocol {
    func didSelectInitiator(_ selectedInitiators: [FilterInitiatorModel]) {
        self.signatoriesList = selectedInitiators
        presenter?.signatories = selectedInitiators
            .compactMap { $0.id }
            .map { "\($0)" }
        mainTableView.reloadData()
    }
}

extension CreateDocFlowViewController: StartDateCalendarViewDelegate {
    func didPickDate(_ dateString: String) {
        presenter?.startDate = dateString
        mainTableView.reloadData()
    }
}

extension CreateDocFlowViewController: EndDateCalendarViewDelegate {
    func didEndPickDate(_ dateString: String) {
        presenter?.endDate = dateString
        mainTableView.reloadData()
    }
}

// MARK: - SaveDocumentAlertDelegate
extension CreateDocFlowViewController: SaveDocumentAlertDelegate {
    func saveDocument() {
        presenter?.sendDocumentToCreate()
    }
}


extension CreateDocFlowViewController: CreateDocFlowPresenterOutputProtocol {
    func gotoPreview(_ document: DocumentViewModel) {
        presenter?.presentEditDocView(with: pdfData, viewmodel: document, documentURL: documentURL)
    }
    
    func validation(_ bool: Bool) {
        createButton.isEnabled = bool
        createButton.backgroundColor = bool ? UIColor(red: 0.88, green: 0.381, blue: 0.229, alpha: 1) : .gray
    }
}
