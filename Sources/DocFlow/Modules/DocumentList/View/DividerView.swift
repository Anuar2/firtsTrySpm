//
//  DividerView.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation
import UIKit

class DividerView: UIView {
    
    init(color: UIColor = UIColor(red: 0, green: 0.474, blue: 0.58, alpha: 1) ) {
        super.init(frame: .zero)
        self.backgroundColor = color
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
    
}
