//
//  DocumentListViewController+TableView.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

//MARK: - UITableViewDataSource
extension DocumentListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = documentList[indexPath.row]
        
        let cell: DocumentListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: model)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension DocumentListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = documentList[indexPath.row]
        
        presenter?.showAdDocumentView(with: model.id)
    }
}

