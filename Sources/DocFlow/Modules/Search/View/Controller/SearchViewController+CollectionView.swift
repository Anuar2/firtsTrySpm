//
//  SearchViewController+CollectionView.swift
//  
//
//  Created by User on 05.12.2023.
//

import UIKit

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = docCategories[indexPath.row]
        let cell: SearchCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(title: model.tab.rawValue, isSelected: model.isSelected)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = docCategories[indexPath.row].tab
        
        switch row {
        case .all:
            return CGSize(width: 34, height: 32)
        case .draft:
            return CGSize(width: 58, height: 32)
        case .inbox:
            return CGSize(width: 78, height: 32)
        case .sent:
            return CGSize(width: 78, height: 32)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        docCategories[indexPath.row].isSelected = true
        selectedCatgory = docCategories[indexPath.row]
        for (index, var searchCategory) in docCategories.enumerated() {
            if index != indexPath.row {
                searchCategory.isSelected = false
                docCategories[index] = searchCategory
            }
        }
        
        presenter?.userChangedTab(to: selectedCatgory.tab.rawValue)
        
        documentListTableView.reloadData()
        collectionView.reloadData()
    }
}
