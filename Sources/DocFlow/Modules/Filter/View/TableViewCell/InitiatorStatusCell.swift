//
//  InitiatorStatusCell.swift
//  
//
//  Created by User on 05.12.2023.
//

import UIKit
import SnapKit

final class InitiatorStatusCell: UITableViewCell {
    
    var selectedInitiators: [FilterInitiatorModel] = []
    
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
        view.register(cellClass: InitiatorSelectedCell.self)
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
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
    }
    
    public func configure(title: String, selectedInitiators: [FilterInitiatorModel]) {
        titleLabel.text = title

        if selectedInitiators.isEmpty {
            titleView.snp.updateConstraints { make in
                make.height.equalTo(48)
            }
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            collectionView.reloadData()
            onReceiveDataCallback?()
        } else {
            collectionView.isHidden = false
            self.selectedInitiators = selectedInitiators
            collectionView.reloadData()
            titleView.snp.updateConstraints { make in
                make.height.equalTo(selectedInitiators.count * 24 + 60)
            }
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(32)
            }
            onReceiveDataCallback?()
        }

        layoutIfNeeded()
    }

}


extension InitiatorStatusCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedInitiators.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = selectedInitiators[indexPath.row]
        
        let cell: InitiatorSelectedCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(title: model.fullName, isSelected: model.isSelected)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedInitiators[indexPath.row].isSelected.toggle()
        selectedInitiators = selectedInitiators.sorted(by: {$0.isSelected && !$1.isSelected})
        collectionView.reloadData()
    }
}
