//
//  UIViewController.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import FloatingPanel
import UIKit

extension UIViewController {
    public func presentFloatingPanel(_ module: UIViewController, layout: FloatingPanelLayout, presentingController: UIViewController) {
        var presenter = DFFloatingPanelPresenter(layout: layout)
        presenter.presentingController = presentingController
        presenter.present(controller: module)
    }
}

extension UIViewController {
    
    /// Method try to popViewController if it's possible, or dismis it
    /// - Parameters:
    ///   - animated: Set animation status
    ///   - completion: Completion closure
    func popIfPossibleOrDissmiss(animated: Bool, completion: (() -> Void)?) {
        if let navCont = self.navigationController, navCont.viewControllers.count > 1 {
            navCont.popViewController(animated: animated)
            completion?()
        } else {
            self.dismiss(animated: animated, completion: completion)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(tapGestureRecognizerTriggered(gestureRecognizer:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapGestureRecognizerTriggered(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func add(_ child: UIViewController, frame: CGRect? = nil, inView: UIView? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        var containingView = view
        if let inView = inView {
            containingView = inView
        }
        containingView?.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// Remove self and his view from the parent view
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    /// Set to navigationItem.backBarButtonItem with empty title
    func hideBackButtonTitle() {
        let item = UIBarButtonItem(title: "  ", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    
    /// Set navigationItem.setHidesBackButton with true parameter
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    /// Make some configuration to navigationBar
    /// - Parameters:
    ///   - tintColor: Set tintColor, by default = .black
    ///   - shadowImage: Set shadowImage, by default = UIImage()
    ///   - backgroundImage: Set backgroundImage, by default = UIImage()
    ///   - backgroundColor: Set UIColor, by default = .white
    ///   - interfaceStyle: Set UIUserInterfaceStyle, by default = .light
    @available(iOS 13.0, *)
    func configureNavBar(tintColor: UIColor = .black,
                         shadowImage: UIImage = UIImage(),
                         backgroundImage: UIImage = UIImage(),
                         backgroundColor: UIColor = .white,
                         interfaceStyle: UIUserInterfaceStyle = .light) {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.tintColor = tintColor
        navigationBar?.setBackgroundImage(backgroundImage, for: .default)
        navigationBar?.shadowImage = shadowImage
        navigationBar?.isTranslucent = false
        self.navigationController?.view.backgroundColor = backgroundColor
        self.overrideUserInterfaceStyle = interfaceStyle
        self.navigationController?.overrideUserInterfaceStyle = interfaceStyle
        self.navigationController?.topViewController?.overrideUserInterfaceStyle = interfaceStyle
    }
    
    
    /// Configure navigation bar and title
    /// - Parameters:
    ///   - interfaceStyle: Set UIUserInterfaceStyle, by default = .light
    ///   - titleFont: Set UIFont, by default = UIFont.systemFont(ofSize: 17, weight: .semibold)
    ///   - titleColor: Set UIColor, by default = .red
    @available(iOS 13.0, *)
    func configureNavBarTitle(interfaceStyle: UIUserInterfaceStyle = .light,
                              titleFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold),
                              titleColor: UIColor = .red) {
        self.overrideUserInterfaceStyle = interfaceStyle
        self.navigationController?.overrideUserInterfaceStyle = interfaceStyle
        self.navigationController?.topViewController?.overrideUserInterfaceStyle = interfaceStyle
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: titleColor,
                                                                   .font: titleFont]
    }
    
    /// Configure navigation bar
    /// - Parameters:
    ///   - barTintColor: Set UIColor, by default = .white
    ///   - isTranslucent: Set isTranslucent, by default = false
    ///   - tintColor: Set UIColor, by default = .black
    func configureNavigationBar(barTintColor: UIColor = .white,
                                isTranslucent: Bool = false,
                                tintColor: UIColor = .black) {
        navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.isTranslucent = isTranslucent
        navigationController?.navigationBar.tintColor = tintColor
        edgesForExtendedLayout = []
    }
    
    /// Configure back button with setting UIImage, if you want to set tintColor attribute, make sure that image rendering mode is .alwaysTemplate
    /// - Parameters:
    ///   - image: Set UIImage
    ///   - tintColor: Set UIColor, by default = .white
    func configureBackButtonImage(image: UIImage,
                                  tintColor: UIColor = .white) {
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleClose))
        button.tintColor = tintColor
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func handleClose() {
        self.popIfPossibleOrDissmiss(animated: true, completion: nil)
    }
    
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
