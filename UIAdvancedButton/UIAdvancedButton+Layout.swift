//
//  UIAdvancedButton+Layout.swift
//  UIAdvancedButton
//  by Steven Syp
//

import UIKit

// MARK: —-  Button Layout & Constraints  —-
extension UIAdvancedButton {
    public override func setNeedsUpdateConstraints() {
        NSLayoutConstraint.deactivate(viewConstraints)
        viewConstraints = []
        super.setNeedsUpdateConstraints()
    }

    public override func updateConstraints() {
        guard viewConstraints.isEmpty else { super.updateConstraints() ; return }
        var constraints = [NSLayoutConstraint]()

        addBackgroundConstraints(&constraints)
        addLayoutGuideConstraints(&constraints)
        addContentConstraints(&constraints)
        NSLayoutConstraint.activate(constraints)
        viewConstraints = constraints
        super.updateConstraints()
    }

    private func addBackgroundConstraints(_ constraints: inout [NSLayoutConstraint]) {
        constraints += [
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }

    private func addLayoutGuideConstraints(_ constraints: inout [NSLayoutConstraint]) {
        let isSpaced = (contentLayout == .horizontalReversedSpaced)
        constraints += (isSpaced ? [
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ] : [
            layoutGuide.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            layoutGuide.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8)
        ]) + [
            layoutGuide.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8),
            layoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8),
            layoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            layoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
    }

    private func addContentConstraints(_ constraints: inout [NSLayoutConstraint]) {
        let isReversed = (contentLayout == .horizontalReversed || contentLayout == .horizontalReversedSpaced)
        if isGlyphEmpty && isTitleEmpty { return }

        constraints += [
            titleLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            glyphView.topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor),
            glyphView.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor),
            glyphView.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor)
        ]

        constraints += isGlyphEmpty ?
            [glyphView.widthAnchor.constraint(equalToConstant: 0)] :
            []

        if !isGlyphEmpty && !isTitleEmpty {
            constraints += isReversed ? [
                titleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
                glyphView.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1),
                glyphView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
            ] : [
                glyphView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
                titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: glyphView.trailingAnchor, multiplier: 1),
                titleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
            ]
        } else if isGlyphEmpty {
            constraints += [
                titleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
            ]
        } else if isTitleEmpty {
            constraints += [
                glyphView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
                glyphView.leadingAnchor.constraint(greaterThanOrEqualTo: layoutGuide.leadingAnchor),
                glyphView.trailingAnchor.constraint(lessThanOrEqualTo: layoutGuide.trailingAnchor)
            ]
        }

    }

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 48)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard previousTraitCollection?.preferredContentSizeCategory != self.traitCollection.preferredContentSizeCategory else { return }
        glyphView.preferredSymbolConfiguration = UIImage.SymbolConfiguration (font: _textFont)
        setNeedsUpdateConstraints()
    }
}
