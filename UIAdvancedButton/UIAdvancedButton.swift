//
//  UIAdvancedButton.swift
//  UIAdvancedButton
//  by Steven Syp
//

import UIKit

@IBDesignable
public class UIAdvancedButton: UIControl {

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

    internal var _animator: UIViewPropertyAnimator!
    internal var _textFont: UIFont {
        let contentWeight: UIFont.Weight = isContentBold ? .semibold : .regular
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
        let font = UIFont.systemFont(ofSize: descriptor.pointSize, weight: contentWeight)
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }


    // MARK: —-  UI Elements  —-
    internal var viewConstraints = [NSLayoutConstraint]()

    lazy internal var layoutGuide = UILayoutGuide()

    lazy internal var backgroundView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    internal var isTitleEmpty: Bool { titleLabel.text?.isEmpty == true || titleLabel.text == nil }
    lazy internal var titleLabel: UILabel = {
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

    internal var isGlyphEmpty: Bool { glyphView.image == nil }
    lazy internal var glyphView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "square.dashed")
        view.contentMode = .scaleAspectFill
        view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: _textFont.pointSize,
            weight: isContentBold ? .semibold : .regular)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    // MARK: —-  Initialization & Life Cycle  —-
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.sharedInit()
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
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        _animator = UIViewPropertyAnimator(duration: 0.25, timingParameters: timing)
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


    // MARK: —-  Helpers  —-
    /// Function to easily update the main button properties. Every argument is optionnal.
    public func set(tintColor: UIColor? = nil, colorStyle: ColorStyle? = nil, contentLayout: ContentLayout? = nil) {
        if let tintColor = tintColor, tintColor != self.tintColor { self.tintColor = tintColor }
        if let colorStyle = colorStyle, colorStyle != self.colorStyle { self.colorStyle = colorStyle }
        if let contentLayout = contentLayout, contentLayout != self.contentLayout { self.contentLayout = contentLayout }
    }

    /// Function to easily update the secondary button properties. Every argument is optionnal.
    public func set(cornerRadius: CGFloat? = nil, isContentBold: Bool? = nil, isAnimatedWhenPressed: Bool? = true) {
        if let cornerRadius = cornerRadius { self.cornerRadius = cornerRadius }
        if let isContentBold = isContentBold, isContentBold != self.isContentBold { self.isContentBold = isContentBold }
        if let isAnimatedWhenPressed = isAnimatedWhenPressed { self.isAnimatedWhenPressed = isAnimatedWhenPressed }
    }


    // MARK: —-  Event Handling  —-
    /// A closure executed when the button is tapped.
    public var tappedHandler: (() -> Void) = {}
    @objc private func didTouchUpInside() {
        sendActions(for: .primaryActionTriggered)
        tappedHandler()
    }
}
