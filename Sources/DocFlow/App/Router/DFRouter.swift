//
//  DFRouter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation
import UIKit

public class DFRouter: NSObject {
    
    // MARK: - Properties
    
    public let navigationController: UINavigationController

    private var completions: [UIViewController: () -> Void] = [:]
    
    // MARK: - Init

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()

        self.navigationController.delegate = self
    }
    
    // MARK: - Methods

    public func present(_ module: Presentable) {
        present(module, animated: true)
    }

    public func present(_ module: Presentable, animated: Bool) {
        present(module, animated: animated, modalPresentationStyle: .automatic)
    }

    public func present(_ module: Presentable, animated: Bool, modalPresentationStyle: UIModalPresentationStyle) {
        let controller = module.toPresent()
        controller.modalPresentationStyle = modalPresentationStyle
        navigationController.present(controller, animated: animated)
    }

    public func presentToTop(_ module: Presentable, animated: Bool, modalPresentationStyle: UIModalPresentationStyle) {
        let controller = module.toPresent()
        controller.modalPresentationStyle = modalPresentationStyle
        navigationController.visibleViewController?.present(controller, animated: animated)
    }

    public func push(_ module: Presentable) {
        push(module, animated: true)
    }

    public func push(_ module: Presentable, hideBottomBarWhenPushed: Bool) {
        push(module, animated: true, hideBottomBarWhenPushed: hideBottomBarWhenPushed, completion: nil)
    }

    public func push(_ module: Presentable, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }

    public func push(_ module: Presentable, completion: (() -> Void)?) {
        push(module, animated: true, completion: completion)
    }

    public func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBarWhenPushed: false, completion: completion)
    }

    public func push(_ module: Presentable, animated: Bool, hideBottomBarWhenPushed: Bool, completion: (() -> Void)?) {
        let controller = module.toPresent()
        guard controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController")
            return
        }

        if let completion = completion {
            completions[controller] = completion
        }

        controller.hidesBottomBarWhenPushed = hideBottomBarWhenPushed
        navigationController.pushViewController(controller, animated: animated)
    }

    public func popModule() {
        popModule(animated: true)
    }

    public func popModule(animated: Bool) {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    public func dismissModule(animated: Bool) {
        dismissModule(animated: animated, completion: nil)
    }

    public func dismissPresentedToTop(_ module: Presentable, animated: Bool) {
        module.toPresent().dismiss(animated: animated, completion: nil)
    }

    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    public func setRootModule(_ module: Presentable) {
        setRootModule(module, isNavigationBarHidden: false)
    }

    public func setRootModule(_ module: Presentable, isNavigationBarHidden: Bool) {
        let controller = module.toPresent()
        navigationController.setViewControllers([controller], animated: false)
        navigationController.isNavigationBarHidden = isNavigationBarHidden
    }

    public func popToRootModule() {
        popToRootModule(animated: true)
    }

    public func popToRootModule(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }

    public func popToModule(module: Presentable, animated: Bool) {
        guard let controller = navigationController.viewControllers.first(where: { type(of: $0) == type(of: module.toPresent()) }) else { return }

        navigationController.popToViewController(controller, animated: true)
    }

    public func getLastModule() -> Presentable? {
        navigationController.viewControllers.last
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }

        completion()
        completions.removeValue(forKey: controller)
    }

}

// MARK: - UINavigationControllerDelegate

extension DFRouter: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard
            let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController)
        else { return }

        runCompletion(for: poppedViewController)
    }
}

// MARK: - Presentable

extension DFRouter: Presentable {
    public func toPresent() -> UIViewController {
        navigationController
    }
}
