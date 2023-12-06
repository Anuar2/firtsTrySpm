//
//  Presentable.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

// MARK: - Presentable

public protocol Presentable {
    func toPresent() -> UIViewController
}

// MARK: - UIViewController + Presentable

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController {
        self
    }
}
