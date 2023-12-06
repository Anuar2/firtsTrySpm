//
//  LastModifiedViewController+CollectionView.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

extension LastModifiedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dateCategory[indexPath.row]
        let cell: CalendarCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(title: model.calendarCategory.rawValue, isSelected: model.isSelected)
        return cell
    }
}

extension LastModifiedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = dateCategory[indexPath.row].calendarCategory
        
        switch row {
        case .today:
            return CGSize(width: 78, height: 32)
        case .yesterday:
            return CGSize(width: 84, height: 32)
        case .week:
            return CGSize(width: 180, height: 32)
        case .custom:
            return CGSize(width: 78, height: 32)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dateCategory[indexPath.row].isSelected = true
        selectedCatgory = dateCategory[indexPath.row]
        for (index, var searchCategory) in dateCategory.enumerated() {
            if index != indexPath.row {
                searchCategory.isSelected = false
                dateCategory[index] = searchCategory
            }
        }
        
        collectionView.reloadData()
    }
    
}
