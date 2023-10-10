SwiftUI SearchField
===

The search input box component can be placed in a non-specific location and is consistent with the default search input box style.

![SearchField](https://github.com/jaywcjlove/swiftui-searchfield/assets/1680273/b3f99b67-995f-4036-a46d-39225982f008)

## Installation

You can add MarkdownUI to an Xcode project by adding it as a package dependency.

1. From the File menu, select Add Packages…
2. Enter https://github.com/jaywcjlove/swiftui-searchfield the Search or Enter Package URL search field
3. Link `Markdown` to your application target

Or add the following to `Package.swift`:

```swift
.package(url: "https://github.com/jaywcjlove/swiftui-searchfield", from: "1.0.0")
```

Or [add the package in Xcode](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app).

## Usage

```swift
import SearchField

struct ContentView: View {
    @State private var searchText = ""
    var body: some View {
        SearchField(searchText, textFieldChanged: { value in
            print("value\(value)")
            searchText = value
        })
        Text(searchText)
    }
}
```

## License

Licensed under the MIT License.
