//
//  DocumentDetailView.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import SnapKit

class DocumentDetailView: UICollectionViewCell {
    
    var documentInfo: DocumentViewModel? {
        didSet {
            reloadInputViews()
        }
    }
    
    let sections: [DocumentDetailViewSection] = [.init(section: .main, rows: [.docNumber, .docName, .docType, .signType, .signatories, .docDescription, .calendar])]

    var docTypes: [FilterDocTypeModel] = [.init(docType: .type1), .init(docType: .type2)]
    
    // TODO: - Переписать логику
    var signatoriesList: [FilterInitiatorModel] = [.init(firstName: "firstName", lastName: "lastname")] {
        didSet {
//            if documentInfo?.initiatorFullname == nil {
//                documentInfo?.initiatorFullname = signatoriesList.first?.fullName
//            } else {
//                signatoriesList.forEach { filterInitiatorModel in
//                    documentInfo?.initiator?.insert(filterInitiatorModel, at: 0)
//                }
//            }
        }
    }
    
    var activeIndexPath: IndexPath?
    
    var createButtonTapped: Bool = false
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View
    private lazy var mainTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    @objc private func createButtonDidTap() {
        createButtonTapped = true
        mainTableView.reloadData()
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    func setupInitialState() { }
    
    
    private func setupViews() {
        [
            BaseDocCell.self,
            SignTypeCell.self,
            SignaturesCell.self,
            CreateDocCalendarCell.self
        ].forEach {
            mainTableView.register(cellClass: $0)
        }
        
        [mainTableView].forEach {
            addSubview($0)
        }
    }
    
    private func makeConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(-8)
        }
    }
}

extension DocumentDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        let isCellInFocus = indexPath == activeIndexPath

        switch row {
        case .docNumber:
            let model = BaseDocCellModel(isOnFocus: isCellInFocus, placeHolder: "Document number", image: UIImage(named: Assets.documentNumberIcon.name), title: "Document number")

            let cell: BaseDocCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textFieldText = documentInfo?.number
            cell.textChanged = { text in
                self.documentInfo?.number = text
                cell.textFieldText = text
            }
            cell.createButtonDidTap = createButtonTapped
            cell.configure(with: model)
            return cell
        case .docName:
            let model = BaseDocCellModel(isOnFocus: isCellInFocus, placeHolder: "Document name", image: UIImage(named: Assets.documentNameIcon.name), title: "Document name")
            
            let cell: BaseDocCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textFieldText = documentInfo?.title
            cell.textChanged = { text in
                self.documentInfo?.title = text
                cell.textFieldText = text
            }
            cell.createButtonDidTap = createButtonTapped
            cell.configure(with: model)
            return cell
        case .docType:
            let model = BaseDocCellModel(isOnFocus: isCellInFocus, placeHolder: "Document type", image: UIImage(named: Assets.agreementIcon.name), title: "Document type")
            let cell: BaseDocCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textFieldText = documentInfo?.type
            cell.textChanged = { text in
                self.documentInfo?.type = text
                cell.textFieldText = text
            }
            cell.createButtonDidTap = createButtonTapped
            cell.configure(with: model)

            return cell
        case .signType:
            let cell: SignTypeCell = tableView.dequeueReusableCell(for: indexPath)
            
            return cell
        case .docDescription:
            let model = BaseDocCellModel(isOnFocus: isCellInFocus, placeHolder: "Description", image: UIImage(named: Assets.descriptionIcon.name), title: "Description")
            
            let cell: BaseDocCell = tableView.dequeueReusableCell(for: indexPath)
            cell.createButtonDidTap = createButtonTapped
            cell.textFieldText = documentInfo?.description
            cell.textChanged = { text in
                self.documentInfo?.description = text
                cell.textFieldText = text
            }
            cell.configure(with: model)

            return cell
        case .signatories:
            let cell: SignaturesCell = tableView.dequeueReusableCell(for: indexPath)
            cell.onReceiveDataCallback = {
                self.mainTableView.beginUpdates()
                self.mainTableView.endUpdates()
            }
            cell.callBackRecieve(signaturesList: signatoriesList)
            
            return cell
        case .calendar:
            let cell: CreateDocCalendarCell = tableView.dequeueReusableCell(for: indexPath)
            cell.onStartDateButtonDidTap = {
//                self.presentStartDateCalendarView()
                print("start")
            }
            cell.configure(starteDateTitle: documentInfo?.startDate ?? "", endDateTitle: documentInfo?.endDate ?? "")
            return cell
        }
    }
}

extension DocumentDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activeIndexPath = indexPath
        mainTableView.reloadData()
    }
}


extension DocumentDetailView: DocTypeViewControllerProtocol {
    func didSelectDocType(_ selectedDocTypes: [FilterDocTypeModel]) {
        self.docTypes = selectedDocTypes.sorted(by: {$0.isSelected && !$1.isSelected})
//        mainTableView.reloadData()
    }
}

extension DocumentDetailView: InitiatorViewControllerProtocol {
    func didSelectInitiator(_ selectedInitiators: [FilterInitiatorModel]) {
        self.signatoriesList = selectedInitiators
        mainTableView.reloadData()
    }
}

extension DocumentDetailView {
    struct DocumentDetailViewSection {
        enum Section {
            case main
        }
        
        enum Row {
            case docNumber
            case docName
            case docType
            case signType
            case signatories
            case docDescription
            case calendar
        }
        
        let section: Section
        var rows: [Row]
    }
}
