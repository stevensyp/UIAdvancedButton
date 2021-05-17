![UIAdvancedButton_GHHeader](https://user-images.githubusercontent.com/16100672/118541794-697e0580-b752-11eb-9c47-76b88c5e8d81.png)
`UIAdvancedButton` is an open-source subclass of UIKit's UIControl implemented as a ready-to-use button, coming with different styles, animations, and parameters. It is designed to be permormant and accessible.

## Features List
### — Color (`tintColor`)
UIAdvancedButton uses only its `tintColor` to define its color layout (background and/or text color) depending on the selected `colorStyle`. You can still set border color independently. Changing `backgroundColor` won't have any effect. Default is `systemBlue`.
### — Color Style (`colorStyle`)
- `.full` \[default] · Plain background color, and light/dark text.
- `.medium` · Background with reduced opactiy, and colored text.
- `.neutral` · Light/dark background (`.systemBackground`), and colored text.
- `.neutralGray` · Light gray background (`.secondarySystemFill`), and colored text.
- `.system` · Clear background and colored text.
### — Content Layout (`contentLayout`)
- `.horizontal` \[default] · Centered text, with the glyph at its left.
- `.horizontalReversed` · Centered text, with the glyph at its right.
- `.horizontalReversedSpaced` · Left-aligned text, with right-aligned glyph.
- `.vertical` · Centered text, with the glyph above.
- `.verticalReversed` · Centered text, with the glyph underneath.
### — Content Weight (`isContentBold`)
Defines if the content's weight of the button is `semibold` or `regular`. Default is `true`.
### — Pressed Animation (`isAnimatedWhenPressed`)
The button will slightly shrink when pressed. Default is `true`.
### — Tap Handling 
The button supports two different ways to handle tapping inside its bounds.
- `button.tappedHandler = { ... }` · Closure block.
- `button.addTarget(...)` · Good old `#selector`.
