//
//  File.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import SnapKit

final class AdDocumentDetailSignatoriesCell: UITableViewCell  {
    
    var signatoriesList: [FilterInitiatorModel] = [] {
        didSet {
            mainView.snp.updateConstraints({ make in
                make.height.equalTo(signatoriesList.count * 48)
            })
            mainView.reloadData()
        }
    }
    
    //MARK: - View
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Signatories"
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var mainView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.register(cellClass: SignatoriesTableViewCell.self)
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
        selectionStyle = .none
        contentView.backgroundColor = .white
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [titleLabel,
         mainView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    public func configure(with signatoriesList: [FilterInitiatorModel]) {
        self.signatoriesList = signatoriesList
    }
}

extension AdDocumentDetailSignatoriesCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signatoriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = signatoriesList[indexPath.row]
        
        let cell: SignatoriesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
