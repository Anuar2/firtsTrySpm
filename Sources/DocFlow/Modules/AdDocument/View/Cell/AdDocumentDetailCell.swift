//
//  AdDocumentDetailCell.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import SnapKit

final class AdDocumentDetailCell: UICollectionViewCell {
    
    //MARK: - Properties
    let sections: [AdDocumentDetailSection] = [.init(section: .main, rows: [.overview,
                                                                            .docNumber,
                                                                            .signatories,
                                                                            .description,
                                                                            .creationDate,
                                                                            .lastModified,
                                                                            .calendar])]
    
    var document: DocumentViewModel? {
        didSet {
            mainView.reloadData()
        }
    }
    
    //MARK: - View
    private lazy var mainView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    private func setup() {
        backgroundColor = .white
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [
            AdDocumentDetailOverViewCell.self,
            AdDocumentDetailBaseCell.self,
            AdDocumentDetailSignatoriesCell.self,
            AdDocumentDetailCalendarCell.self
        ].forEach {
            mainView.register(cellClass: $0)
        }
        
        [mainView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func configure(with model: DocumentViewModel) {
        document = model
    }
}


extension AdDocumentDetailCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = document else {return UITableViewCell()}
        let row = sections[indexPath.section].rows[indexPath.row]
        
        switch row {
        case .overview:
            let cell: AdDocumentDetailOverViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: model)
            return cell
        case .docNumber:
            let baseModel = AdDocumentDetailBaseCellModel(title: "Document number", iconImage: "documentNumberIcon", subtitle: model.number)
            let cell: AdDocumentDetailBaseCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: baseModel)
            return cell
        case .signatories:
            let cell: AdDocumentDetailSignatoriesCell = tableView.dequeueReusableCell(for: indexPath)
            cell.signatoriesList = document?.signatories ?? [.init(id: "0", firstName: "Aidyn", lastName: "Belassarov", position: "Signed on Aug 17, 2022 ", avatar: Assets.avatarIcon.name)]
            return cell
        case .description:
            let baseModel = AdDocumentDetailBaseCellModel(title: "Description", iconImage: "textDescriptionIcon", subtitle: model.description ?? "")
            let cell: AdDocumentDetailBaseCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: baseModel)
            return cell
        case .creationDate:
            let baseModel = AdDocumentDetailBaseCellModel(title: "Creation date", iconImage: "calendarAddIcon", subtitle: model.createdAt)
            let cell: AdDocumentDetailBaseCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: baseModel)
            return cell
        case .lastModified:
            let baseModel = AdDocumentDetailBaseCellModel(title: "Last modified", iconImage: "calendarEditIcon", subtitle: model.updatedAt)
            let cell: AdDocumentDetailBaseCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: baseModel)
            return cell
        case .calendar:
            let cell: AdDocumentDetailCalendarCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(starteDateTitle: model.startDate ?? String(), endDateTitle: model.endDate ?? String())
            return cell
        }
    }
}

extension AdDocumentDetailCell {
    struct AdDocumentDetailSection {
        enum Section {
            case main
        }
        
        enum Row {
            case overview
            case docNumber
            case signatories
            case description
            case creationDate
            case lastModified
            case calendar
        }
        
        let section: Section
        var rows: [Row]
    }
}

