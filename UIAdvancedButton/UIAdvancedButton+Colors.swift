//
//  UIAdvancedButton+Colors.swift
//  UIAdvancedButton
//  by Steven Syp
//

import UIKit

extension UIAdvancedButton {
    public override func tintColorDidChange() {
        updateColors()
    }

    public override var isEnabled: Bool {
        didSet { alpha = isEnabled ? 0.4 : 1.0 }
    }

    internal func updateColors() {
        backgroundColor = .clear
        titleLabel.textColor = colorStyle == .full ? .systemBackground : tintColor
        glyphView.tintColor = colorStyle == .full ? .systemBackground : tintColor
        switch colorStyle {
        case .system:       backgroundView.backgroundColor = .clear
        case .full:         backgroundView.backgroundColor = tintColor
        case .medium:       backgroundView.backgroundColor = tintColor.withAlphaComponent(0.25)
        case .neutral:      backgroundView.backgroundColor = .systemBackground
        case .neutralGray:  backgroundView.backgroundColor = .secondarySystemFill
        }
    }
}
