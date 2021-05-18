![UIAdvancedButton_GHHeader](https://user-images.githubusercontent.com/16100672/118541794-697e0580-b752-11eb-9c47-76b88c5e8d81.png)

`UIAdvancedButton` is an open-source subclass of UIKit's UIControl implemented as a ready-to-use button, coming with different styles, animations, and parameters. It is designed to be permormant and accessible.

## 📲 Installation
* [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'UIAdvancedButton'
```

* [Swift Package Manager](https://swift.org/package-manager/):

```swift
  .package(url: "https://github.com/stevensyp/UIAdvancedButton.git")
```

## Features List
### — Color (`tintColor`)
UIAdvancedButton uses only its `tintColor` to define its color layout (background and/or text color) depending on the selected `colorStyle`. You can still set border color independently. Changing `backgroundColor` won't have any effect. Default is `systemBlue`.
### — Color Style (`colorStyle`)
| Property | Detail | Preview
| -------- | ------ | -------
`.full` | (Default) Plain background color, and light/dark text. | ![full](https://user-images.githubusercontent.com/16100672/118592465-44b37d80-b7a6-11eb-800d-14dd958022b7.png)
`.medium` | Background with reduced opactiy, and colored text. | ![medium](https://user-images.githubusercontent.com/16100672/118592487-4c732200-b7a6-11eb-8ab4-0bb437a58a19.png)
`.neutral` | Light/dark background (`.systemBackground`), and colored text. | ![neutral](https://user-images.githubusercontent.com/16100672/118592517-572db700-b7a6-11eb-934b-3ed789104f4e.png)
`.neutralGray` | Light gray background (`.secondarySystemFill`), and colored text. | ![neutralGray](https://user-images.githubusercontent.com/16100672/118592530-5c8b0180-b7a6-11eb-802b-b5c7d06fa126.png)
`.system` | Clear background and colored text. | ![system](https://user-images.githubusercontent.com/16100672/118592550-6280e280-b7a6-11eb-8df7-f819ea63be67.png)

### — Content Layout (`contentLayout`)
| Property | Detail | Preview
| -------- | ------ | -------
`.horizontal` | (Default) Centered text, with the glyph at its left. | ![horizontal](https://user-images.githubusercontent.com/16100672/118592758-c73c3d00-b7a6-11eb-931f-7bfadd609ba9.png)
`.horizontalReversed` | Centered text, with the glyph at its right. | ![horizontalReversed](https://user-images.githubusercontent.com/16100672/118592772-cd321e00-b7a6-11eb-9612-5e6c63b257f4.png)
`.horizontalReversedSpaced` | Left-aligned text, with right-aligned glyph. | ![horizontalReversedSpaced](https://user-images.githubusercontent.com/16100672/118592780-d1f6d200-b7a6-11eb-8019-78007fcda63f.png)

### — Content Weight (`isContentBold`)
Defines if the content's weight of the button is `semibold` or `regular`. Default is `true`.
### — Pressed Animation (`isAnimatedWhenPressed`)
The button will slightly shrink when pressed. Default is `true`.
### — Tap Handling 
The button supports two different ways to handle tapping inside its bounds.
- `button.tappedHandler = { ... }` · Closure block.
- `button.addTarget(...)` · Good old `#selector`.
