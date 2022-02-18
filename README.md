# KIEM

Open Source Library, converting misspelled Korean string into English string

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-orange.svg)](#swift-package-manager) ![Swift 5.5](https://img.shields.io/badge/Swift-5.5-orange.svg) ![platforms](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-lightgrey.svg) [![license MIT](https://img.shields.io/github/license/738/inko.svg)](#license)

## Installation

KIEM supports macOS 10.15+, iOS 9.0+.

#### Swift Package Manager

If you use Swift Package Manager, simply add ReactiveSwift as a dependency
of your package in `Package.swift`:
```
.package(url: "https://github.com/knine79/KIEM.git")
```

## Usage

```
"KIEM은 Korean in English Mode의 약자입니다.😀👍".stringTypedInEnglishMode
```
Its value is "KIEMdms Korean in English Modedml dirwkdlqslek.😀👍".

```
"ㅗ디ㅣㅐ, ㅏㅑ드".stringTypedInEnglishMode
```
Its value is "hello, kiem".

## License
KIEM is released under the MIT License. See [LICENSE](https://github.com/knine79/KIEM/blob/main/LICENSE) file for details.
