//
//  UIAdvancedButton.swift
//  UIAdvancedButton
//  by Steven Syp
//

import UIKit

@IBDesignable
open class UIAdvancedButton: UIControl {

    // MARK: —-  Button Properties  —-
    /// The current title that is displayed on the button.
    @IBInspectable public var title: String? { didSet {
        titleLabel.text = title
        setNeedsLayout()
    }}

    /// The current glyph/symbol (UIImage) that is displayed on the button.
    @IBInspectable public var glyph: UIImage? { didSet {
        glyphView.image = glyph
        setNeedsLayout()
    }}

    /// The radius used for rounded corners of the button’s background. The default value is set to `12.0`.
    public var cornerRadius: CGFloat = 12.0 { didSet {
        if abs(layer.cornerRadius - cornerRadius) < CGFloat.ulpOfOne { return }
        layer.cornerRadius = cornerRadius
        setNeedsLayout()
    }}

    /// A Boolean value indicating whether the button's content is bold.  The default value is set to `true`.
    public var isContentBold: Bool = true { didSet {
        titleLabel.font = _textFont
        setNeedsLayout()
    }}

    /// The color style of the button.  The default value is set to `.full`.
    public var colorStyle: ColorStyle = .full { didSet { updateColors() }}

    /// The content layout of the button. The default value is set to `.horizontal`.
    public var contentLayout: ContentLayout = .horizontal { didSet { setNeedsUpdateConstraints() }}

    /// A Boolean value indicating whether the buttonis animated when pressed.  The default value is set to `true`.
    public var isAnimatedWhenPressed: Bool = true

    /// A closure executed when the button is tapped.
    public var tappedHandler: (() -> Void) = {}

    private var _timing: UICubicTimingParameters!
    private var _animator: UIViewPropertyAnimator!
    private var _textFont: UIFont {
        let contentWeight: UIFont.Weight = isContentBold ? .semibold : .regular
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        let font = UIFont.systemFont(ofSize: descriptor.pointSize, weight: contentWeight)
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }


    // MARK: —-  UI Elements  —-
    private var viewConstraints = [NSLayoutConstraint]()
    lazy private var backgroundView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy private var layoutGuide: UILayoutGuide = {
        let guide = UILayoutGuide()
        guide.identifier = "ContentLayoutGuide"
        return guide
    }()

    private var isTitleEmpty: Bool { titleLabel.text?.isEmpty == true || titleLabel.text == nil }
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Button"
        label.font = _textFont
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.defaultHigh - 10, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var isGlyphEmpty: Bool { glyphView.image == nil }
    lazy private var glyphView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "square.dashed")
        view.contentMode = .scaleAspectFill
        view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: _textFont.pointSize + 2,
            weight: isContentBold ? .semibold : .regular)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    // MARK: —-  Initialization & Life Cycle  —-
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        titleLabel.font = _textFont
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.sharedInit()
    }

    private func sharedInit() {
        _timing = UICubicTimingParameters(animationCurve: .easeInOut)
        _animator = UIViewPropertyAnimator(duration: 0.25, timingParameters: _timing)
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        isAccessibilityElement = true
        accessibilityTraits = .button

        clipsToBounds = true
        layer.cornerCurve = .continuous
        layer.cornerRadius = cornerRadius

        addSubview(backgroundView)
        addLayoutGuide(layoutGuide)
        insertSubview(titleLabel, aboveSubview: backgroundView)
        insertSubview(glyphView, aboveSubview: backgroundView)
        setNeedsUpdateConstraints()
        updateColors()
    }

    /// Function to easily update multiple button properties at once. Every argument is optionnal.
    public func set(tintColor: UIColor? = nil,
                    colorStyle: ColorStyle? = nil,
                    contentLayout: ContentLayout? = nil,
                    cornerRadius: CGFloat? = nil,
                    isContentBold: Bool? = nil,
                    isAnimatedWhenPressed: Bool? = true) {
        if let tintColor = tintColor, tintColor != self.tintColor { self.tintColor = tintColor }
        if let colorStyle = colorStyle, colorStyle != self.colorStyle { self.colorStyle = colorStyle }
        if let contentLayout = contentLayout, contentLayout != self.contentLayout { self.contentLayout = contentLayout }
        if let cornerRadius = cornerRadius { self.cornerRadius = cornerRadius }
        if let isContentBold = isContentBold, isContentBold != self.isContentBold { self.isContentBold = isContentBold }
        if let isAnimatedWhenPressed = isAnimatedWhenPressed { self.isAnimatedWhenPressed = isAnimatedWhenPressed }
    }

}


// MARK: —-  Button Colors  —-
extension UIAdvancedButton {
    open override func tintColorDidChange() {
        updateColors()
    }

    open override var isEnabled: Bool {
        didSet { alpha = isEnabled ? 0.4 : 1.0 }
    }

    private func updateColors() {
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


// MARK: —-  Button Layout & Constraints  —-
extension UIAdvancedButton {
    public override func setNeedsUpdateConstraints() {
        NSLayoutConstraint.deactivate(viewConstraints)
        viewConstraints = []
        super.setNeedsUpdateConstraints()
    }

    public override func updateConstraints() {
        guard viewConstraints.isEmpty else { super.updateConstraints() ; return }
        let isReversed = (contentLayout == .horizontalReversed || contentLayout == .horizontalReversedSpaced)
        let isSpaced = (contentLayout == .horizontalReversedSpaced)
        var constraints = [NSLayoutConstraint]()

        // Background View
        constraints += [
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        // Layout Guide
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

        // Label & Glyph Views
        constraints += (isReversed ? [
            titleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            glyphView.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1),
            glyphView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        ] : [
            glyphView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: glyphView.trailingAnchor, multiplier: 1),
            titleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
        ]) + [
            titleLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            glyphView.topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor),
            glyphView.bottomAnchor.constraint(greaterThanOrEqualTo: layoutGuide.bottomAnchor),
            glyphView.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
            glyphView.widthAnchor.constraint(greaterThanOrEqualTo: glyphView.heightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
        viewConstraints = constraints
        super.updateConstraints()
    }

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 48)
    }
}


// MARK: —-  Tap Handling  —-
extension UIAdvancedButton {
    @objc func didTouchUpInside() {
        sendActions(for: .primaryActionTriggered)
        tappedHandler()
    }

    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        _animator.stopAnimation(false)
        _animator.finishAnimation(at: .current)
        _animator.addAnimations {
            self.alpha = 0.8
            if self.isAnimatedWhenPressed {
                self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }
        }

        _animator.startAnimation()
        return true
    }

    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        _animator.stopAnimation(false)
        _animator.finishAnimation(at: .current)
        _animator.addAnimations {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

        _animator.startAnimation()
    }

}

// MARK: —-  Subtypes  —-
extension UIAdvancedButton {
    public enum ContentLayout {
        /// Centered text, and left glyph.
        case horizontal
        /// Centered text, and right glyph.
        case horizontalReversed
        /// Left-aligned text, and right-aligned glyph.
        case horizontalReversedSpaced
    }

    public enum ColorStyle {
        /// Clear background, and colored text.
        case system
        /// Plain background color, and light/dark text.
        case full
        /// Background with reduced opactiy, and colored text.
        case medium
        /// Light/dark background (`.systemBackground`), and colored text.
        case neutral
        /// Light gray background (`.secondarySystemFill`), and colored text.
        case neutralGray
    }
}
