//
//  DocStatusCell.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import SnapKit

final class DocStatusCell: UITableViewCell {
    
    //MARK: - Properties
    var docStatuses: [FilterDocStatusModel] = []
    var onReceiveDataCallback: (([FilterDocStatusModel]) -> Void)?

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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = false
        view.register(cellClass: DefaultCollectionViewCell.self)
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
        
        [titleLabel, collectionView].forEach {
            titleView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.height.equalTo(18)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
    }
    
    public func configure(title: String, docStatuses: [FilterDocStatusModel]) {
        titleLabel.text = title
        
        if !docStatuses.isEmpty {
            self.docStatuses = docStatuses
            collectionView.snp.updateConstraints { make in
                make.height.equalTo((docStatuses.count) * 24)
            }
            collectionView.reloadData()
        } else {
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension DocStatusCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docStatuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = docStatuses[indexPath.row]
        
        let cell: DefaultCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        switch model.docStatus {
        case .draft:
            cell.configure(title: "Draft", isSelected: model.isSelected)
        case .onSigning:
            cell.configure(title: "On Signing", isSelected: model.isSelected)
        case .signed:
            cell.configure(title: "Signed", isSelected: model.isSelected)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DocStatusCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        docStatuses[indexPath.row].isSelected.toggle()
        onReceiveDataCallback?(docStatuses)
        collectionView.reloadData()
    }
}

struct FilterDocStatusModel {
    var docStatus: DocStatus
    var isSelected: Bool = false
}
