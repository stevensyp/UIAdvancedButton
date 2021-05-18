//
//  UIAdvancedButton+Subtypes.swift
//  UIAdvancedButton
//  by Steven Syp
//

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
