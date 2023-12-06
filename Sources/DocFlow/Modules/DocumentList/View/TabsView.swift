//
//  TabsView.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation
import UIKit

fileprivate enum TabsViewConstants {
    static let tabLineColor: UIColor = UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1)
    static let textColor: UIColor = .gray
    static let selectedTextColor: UIColor = UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1)
    static let textFont: UIFont = .systemFont(ofSize: 14, weight: .medium)
}

protocol TabsViewViewDelegate: AnyObject {
    func didTap(at index: Int)
}

class TabsView: UIView {
    
    // MARK: - Properties
    weak var delegate:TabsViewViewDelegate?
    private var tabLineViewLeadingConstraint: NSLayoutConstraint?
    private var tabLineViewWidthConstraint: NSLayoutConstraint?
    let items:[String]
    private var selectedIndex = 0
    private var currentTabLineOffset:CGFloat = 0
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TabsViewCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.left = 16
        collectionView.contentInset.right = 16
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let tabLineView:UIView = {
        let view = UIView()
        view.backgroundColor = TabsViewConstants.tabLineColor
        return view
    }()
    
    let topDividerView = DividerView()
    
    // MARK: - Lifecycle
    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        setup()
        tapped(index: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Helpers
    private func setup() {
        backgroundColor = .gray
        
        [collectionView, topDividerView, tabLineView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        collectionView.top(to: topAnchor)
        collectionView.bottom(to: bottomAnchor)
        collectionView.leading(to: leadingAnchor)
        collectionView.trailing(to: trailingAnchor)
        
        tabLineView.bottom(to: bottomAnchor)
        tabLineView.height(2)
        
        tabLineViewWidthConstraint = tabLineView.width(0)
        tabLineViewLeadingConstraint = tabLineView.leading(to: leadingAnchor)
        
        topDividerView.top(to: topAnchor)
        topDividerView.leading(to: leadingAnchor)
        topDividerView.trailing(to: trailingAnchor)
    }
    
    // MARK: - Selectors
    private func tapped(index: Int) {
        setActiveTab(at: index)
        delegate?.didTap(at: index)
    }
    
    func selectItem(at index: Int) {
        setActiveTab(at: index)
    }
    
    func setActiveTab(at index: Int) {
        guard items.indices.contains(index) else { return }
        
        let prevSelectedIndex = selectedIndex
        selectedIndex = index
        tabLineViewWidthConstraint?.constant = getWidth(at: index)
        
        self.collectionView.reloadItems(at: [
            IndexPath(item: prevSelectedIndex, section: 0),
            IndexPath(item: index, section: 0)
        ])
        
        let leftPadding = self.collectionView.contentInset.left
        var offset = -leftPadding + leftPadding
        for i in 0..<selectedIndex where selectedIndex > 0 {
            let width = getWidth(at: i)
            offset += width
        }
        currentTabLineOffset = offset
        let pointX = collectionView.contentOffset.x
        tabLineViewLeadingConstraint?.constant = offset - pointX
        
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
    }
    
    private func getWidth(at index: Int) -> CGFloat {
        items[index].widthOfString(usingFont: TabsViewConstants.textFont) + 24
    }
}

extension TabsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TabsViewCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setupTitle(items[indexPath.item])
        cell.setActive(indexPath.item == selectedIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 24
        width += items[indexPath.item].widthOfString(usingFont: TabsViewConstants.textFont)
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapped(index: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pointX = scrollView.contentOffset.x
        tabLineViewLeadingConstraint?.constant = currentTabLineOffset - pointX
    }
}

class TabsViewCollectionViewCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = TabsViewConstants.textColor
        label.font = TabsViewConstants.textFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        titleLabel.top(10, to: contentView.topAnchor)
        titleLabel.centerX(to: contentView.centerXAnchor)
    }
    
    func setupTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setActive(_ isActive: Bool) {
        titleLabel.textColor = isActive ? TabsViewConstants.selectedTextColor : TabsViewConstants.textColor
    }
}

