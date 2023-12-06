//
//  UIView.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {

    @discardableResult
    func top(_ space: CGFloat = 0, to: NSLayoutAnchor<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        let layout = self.topAnchor.constraint(equalTo: to, constant: space)
        layout.isActive = true
        return layout
    }
    
    @discardableResult
    func leading(_ space: CGFloat = 0, to: NSLayoutAnchor<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        let layout = self.leadingAnchor.constraint(equalTo: to, constant: space)
        layout.isActive = true
        return layout
    }

    @discardableResult
    func trailing(_ space: CGFloat = 0, to: NSLayoutAnchor<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        let layout = self.trailingAnchor.constraint(equalTo: to, constant: space)
        layout.isActive = true
        return layout
    }

    @discardableResult
    func bottom(_ space: CGFloat = 0, to: NSLayoutAnchor<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        let layout = self.bottomAnchor.constraint(equalTo: to, constant: space)
        layout.isActive = true
        return layout
    }

    @discardableResult
    func centerY(_ space: CGFloat = 0, to: NSLayoutAnchor<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        let layout = self.centerYAnchor.constraint(equalTo: to, constant: space)
        layout.isActive = true
        return layout
    }

    @discardableResult
    func centerX(_ space: CGFloat = 0, to: NSLayoutAnchor<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        let layout = self.centerXAnchor.constraint(equalTo: to, constant: space)
        layout.isActive = true
        return layout
    }
    
    @discardableResult
    func height(_ space: CGFloat) -> NSLayoutConstraint {
        let layout = self.heightAnchor.constraint(equalToConstant: space)
        layout.isActive = true
        return layout
    }
    
    @discardableResult
    func width(_ space: CGFloat) -> NSLayoutConstraint {
        let layout = self.widthAnchor.constraint(equalToConstant: space)
        layout.isActive = true
        return layout
    }
    
    func size(_ size: CGSize) {
        self.height(size.height)
        self.width(size.width)
    }
}

extension UIView {
    func rotate(duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber(value: Double.pi * 2.0)
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: "rotationAnimation")
    }
}
