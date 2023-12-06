//
//  CreationDateCell.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation
import UIKit

final class CreationDateCell: UITableViewCell {
    
    var date: [String] = []
    
    var onReceiveDataCallback: (() -> Void)?
    
    //MARK: - View
    private lazy var titleView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = UIFont(name: "EuclidCircularB-Regular", size: 14)
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "chevronRIghtIcon")
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.register(cellClass: DateSelectionCell.self)
        return view
    }()

    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = DFColor.lighBackground
        return view
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setup() {
        setupLayer()
        setupViews()
        makeConstraints()
    }
    
    private func setupLayer() {
        selectionStyle = .none
        backgroundColor = DFColor.lighBackground
    }
    
    private func setupViews() {
        [titleView, emptyView].forEach {
            contentView.addSubview($0)
        }
        
        [titleLabel, collectionView, iconImageView].forEach {
            titleView.addSubview($0)
        }
        
        collectionView.isHidden = true

    }
    
    private func makeConstraints() {
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.height.equalTo(18)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
            make.height.width.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
    }
    
    public func configure(title: String, date: [String]) {
        titleLabel.text = title
        if date.isEmpty {
            collectionView.isHidden = true
            collectionView.reloadData()
            titleView.snp.updateConstraints { make in
                make.height.equalTo(48)
            }
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            onReceiveDataCallback?()
        } else {
            self.date = date
            collectionView.isHidden = false
            collectionView.reloadData()
            titleView.snp.updateConstraints { make in
                make.height.equalTo(date.count * 24 + 60)
            }
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(32)
            }
            onReceiveDataCallback?()
        }

        layoutIfNeeded()
    }

}


extension CreationDateCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return date.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = date[indexPath.row]
        
        let cell: DateSelectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(title: model, isSelected: true)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: date.count * 40 + 200, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
