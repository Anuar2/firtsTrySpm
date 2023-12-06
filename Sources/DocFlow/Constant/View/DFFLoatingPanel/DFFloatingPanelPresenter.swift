//
//  DFFloatingPanelPresenter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import FloatingPanel
import UIKit

public final class DFFloatingPanelPresenter {

    // MARK: - Properties

    public weak var presentingController: UIViewController?

    private let panelLayout: FloatingPanelLayout

    private lazy var appearance: SurfaceAppearance = {
        let appearance = SurfaceAppearance()
        appearance.backgroundColor = .white
        appearance.cornerRadius = 16
        return appearance
    }()

    // MARK: - Init

    public init(layout: FloatingPanelLayout) {
        panelLayout = layout
    }

    // MARK: - Methods

    public func present(controller: UIViewController) {
        let viewController = DFFloatingPanelController()
        viewController.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        viewController.delegate = self
        viewController.isRemovalInteractionEnabled = true
        viewController.set(contentViewController: controller)
        viewController.surfaceView.appearance = appearance
        DispatchQueue.main.async { [weak self] in
            self?.presentingController?.present(viewController, animated: true)
        }
    }

}

// MARK: - FloatingPanelControllerDelegate

extension DFFloatingPanelPresenter: FloatingPanelControllerDelegate {

    public func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        panelLayout
    }

    public func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        presentingController = nil
    }

}
