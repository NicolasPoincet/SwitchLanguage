# Switch Language

[![Travis CI](https://travis-ci.org/NicolasPoincet/SwitchLanguage.svg?branch=master)](https://travis-ci.org/NicolasPoincet/SwitchLanguage) [![Swift Version](https://img.shields.io/badge/swift-4.0-orange.svg?style=flat)](https://developer.apple.com/swift/) [![SwitchLanguage version](https://cocoapod-badges.herokuapp.com/v/SwitchLanguage/badge.png)](https://cocoapods.org/pods/SwitchLanguage) [![SwitchLanguage Platform](https://cocoapod-badges.herokuapp.com/p/SwitchLanguage/badge.svg)](https://cocoapods.org/pods/SwitchLanguage) [![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/nicolaspoincet/switchlanguage)](http://clayallsopp.github.io/readme-score?url=https://github.com/nicolaspoincet/switchlanguage) [![codecov](https://codecov.io/gh/NicolasPoincet/SwitchLanguage/branch/master/graph/badge.svg)](https://codecov.io/gh/NicolasPoincet/SwitchLanguage) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Switch Language help you to easily translate your iOS app.

## CocoaPods Setup

```
pod 'SwitchLanguage, '~> 1.0'
```

## Usage

First, you must import Language on each Swift file that will contain text to translate.
```swift
import SwitchLanguage
```

Then, you can add `.localized()` after any `String` object you want to translate.
```swift
textLabel.text = "Hello".localized()
```

Next, add the String key in each `Localizable.string` file with its translation.
```
"Hello" = "Bonjour";
```

Enjoy ! :)

## Features

To set the table name:
```swift
Language.setTableName("TranslationFile")
```

To get the table name:
```swift
Language.getTableName()
```

To get all available languages:
```swift
Language.getAllLanguages()
```

To reset language to default:
```swift
Language.resetCurrentLanguageToDefault()
```

To set current language:
```swift
Language.setCurrentLanguage("fr")
```

To get current language:
```swift
Language.getCurrentLanguage()
```

To get default language:
```swift
Language.getDefaultLanguage()
```

## UI

![alt text](https://media.giphy.com/media/xUNd9ImxioK63t5R5K/giphy.gif)

## Authors

* **Bérangère LA TOUCHE**
* **Hoang-Nam NGUYEN**
* **Nicolas POINCET**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
