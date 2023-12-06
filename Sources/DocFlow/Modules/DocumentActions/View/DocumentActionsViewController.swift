//
//  DocumentActionsViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import PDFKit

class DocumentActionsViewController: UIViewController, DocumentActionsViewInput {

    var output: DocumentActionsViewOutput?
    
    let sections: [DocumentActionsSection] = [ .init(section: .main, rows: [.edit,
                                                                            .download,
                                                                            .void,
                                                                            .delete])]
    
    let document: DocumentViewModel
    
    init(output: DocumentActionsViewOutput? = nil, document: DocumentViewModel) {
        self.output = output
        self.document = document
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View
    private lazy var navigationView: DFFloatingPanelNavBar = {
        let view = DFFloatingPanelNavBar()
        view.navigationTitle = "Actions"
        view.dissmiss = { [weak self] in
            self?.output?.dissmiss()
        }
        return view
    }()
    
    private lazy var mainTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = DFColor.lighBackground
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func updateViewConstraints() {
        self.view.frame.size.height = UIScreen.main.bounds.height/2
        self.view.frame.origin.y = UIScreen.main.bounds.height -  UIScreen.main.bounds.height/2
        self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        super.updateViewConstraints()
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        view.backgroundColor = DFColor.lighBackground
        setup()
    }

    // MARK: UploadDocumentViewInput
    func setupInitialState() {
    }
    

    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [
            DocumentActionsCell.self
        ].forEach {
            mainTableView.register(cellClass: $0)
        }
        
        [
            navigationView,
            mainTableView
        ].forEach {
            view.addSubview($0)
        }
    }

    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/13)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().offset(24)
        }
    }
}

extension DocumentActionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]

        switch row {
        case .edit:
            let cell: DocumentActionsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Edit", icon: Assets.editRegular.name)
            cell.roundTopCorners = true
            return cell
        case .download:
            let cell: DocumentActionsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Download", icon: Assets.downloadIcon.name)

            return cell
        case .void:
            let cell: DocumentActionsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Void", icon: Assets.voidIcon.name)

            return cell
        case .delete:
            let cell: DocumentActionsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: "Delete", icon: Assets.deleteIcon.name)
            cell.roundBottomCorners = true
            return cell
        }
    }

}

extension DocumentActionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]

        switch row {
        case .edit:
            output?.presentEditDociment()
        case .download:
            output?.downloadDocument(document: document)
        case .void:
            print("")
        case .delete:
            output?.deleteDocument(document: document)
        }
    }
}

extension DocumentActionsViewController: EditDocumentAlertDelegate {
    func saveAsDraft() {
        output?.showEditAdDocumentInfoView(id: document.id)
    }
}

extension DocumentActionsViewController: DeleteDocumentAlertDelegate {
    func deleteDocument() {
        output?.dissmiss()
    }
}
