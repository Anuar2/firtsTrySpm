//
//  DFFloatingPanelLayout.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import FloatingPanel
import UIKit

public final class DFFloatingPanelLayout: FloatingPanelLayout {

    // MARK: - Properties

    public var position: FloatingPanelPosition = .bottom

    public var initialState: FloatingPanelState = .half

    public var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea)
        ]
    }

    // MARK: - Init

    public init() {}

    // MARK: - Methods

    public func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        0.4
    }

}

