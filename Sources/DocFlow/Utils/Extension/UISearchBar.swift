//
//  UISearchBar.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

extension UISearchBar {
    func changeSearchBarColor(color : UIColor, borderColor: CGColor?) {
        var textField: UITextField? {
            return subviews.map { $0.subviews.first(where: { $0 is UITextInputTraits}) as? UITextField }
                .compactMap { $0 }
                .first
        }
    }
}
