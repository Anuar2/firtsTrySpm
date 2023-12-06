//
//  CustomLoaderView.swift
//
//
//  Created by Anuar Orazbekov on 06.12.2023.
//

import UIKit
import SnapKit

class CustomLoaderView: UIView {
    
    //MARK: - View
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "spinnerIcon")
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setup() {
        setupViews()
        makeConstriants()
    }
    
    private func setupViews() {
        [imageView].forEach {
            addSubview($0)
        }
    }
    
    private func makeConstriants() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func startAnimating() {
        imageView.rotate(duration: 1)
        isHidden = false
    }
    
    func stopAnimating() {
        imageView.layer.removeAllAnimations()
        isHidden = true
//        removeFromSuperview()
    }
}

