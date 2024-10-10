SwiftUI SearchField
===


[![Buy me a coffee](https://img.shields.io/badge/Buy%20me%20a%20coffee-048754?logo=buymeacoffee)](https://jaywcjlove.github.io/#/sponsor)
[![CI](https://github.com/jaywcjlove/swiftui-searchfield/actions/workflows/ci.yml/badge.svg)](https://github.com/jaywcjlove/swiftui-searchfield/actions/workflows/ci.yml)
![SwiftUI Support](https://shields.io/badge/SwiftUI-macOS%20v10.15-green?logo=Swift&style=flat)

The search input box component can be placed in a non-specific location and is consistent with the default search input box style.

![SearchField](https://github.com/jaywcjlove/swiftui-searchfield/assets/1680273/b3f99b67-995f-4036-a46d-39225982f008)

## Installation

You can add MarkdownUI to an Xcode project by adding it as a package dependency.

1. From the File menu, select Add Packages…
2. Enter https://github.com/jaywcjlove/swiftui-searchfield the Search or Enter Package URL search field
3. Link `SearchField` to your application target

Or add the following to `Package.swift`:

```swift
.package(url: "https://github.com/jaywcjlove/swiftui-searchfield", from: "1.0.1")
```

Or [add the package in Xcode](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app).

## Usage

```swift
public init(searchText: Binding<String>,
            placeholder: String? = nil,
            onEditingChanged: ((Bool) -> Void)? = nil,
            onTextChanged: ((String) -> Void)? = nil,
            searchField: ((NSSearchField) -> Void)? = nil)
```

Parameters

- `searchText`: A binding to the string for the search text.
- `placeholder`: An optional placeholder string that is displayed when the input field is empty.
- `onEditingChanged`: A closure that is called when the editing state changes, returning a boolean value that indicates whether editing has started or ended.
- `onTextChanged`: A closure that is called when the text changes, returning the current search text.
- `searchField`: A closure that allows access to the NSSearchField instance for custom operations.


```swift
import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    var body: some View {
        SearchField(searchText: $searchText, placeholder: "Search...", searchField: { searchField in
            print(type(of: searchField)) // -> NSSearchField
        })
    }
}
```

In this example, SearchField is initialized and bound to the @State variable searchText, and the text entered by the user will be printed to the console.

### Example: Handling Editing State

```swift
import SwiftUI
import SearchField

struct ContentView: View {
    @State private var searchText = ""
    @State private var isEditing = false

    var body: some View {
        SearchField(
            searchText: $searchText,
            placeholder: "Search...",
            onEditingChanged: { editing in
                isEditing = editing
                print("Editing started: \(editing)")
            },
            onTextChanged: { text in
                print("Search text changed to: \(text)")
            }
        ) { searchField in
            print(type(of: searchField)) // -> NSSearchField
        }
    }
}
```

In this example, the onEditingChanged closure is used to handle changes in the editing state.

### Example: Accessing the NSSearchField Instance

```swift
import SwiftUI
import SearchField

struct ContentView: View {
    @State private var searchText = ""
    @State private var searchField: NSSearchField?

    var body: some View {
        SearchField(
            searchText: $searchText,
            placeholder: "Search...",
            searchField: { field in
                // 自定义 NSSearchField 的属性
                field.isBordered = true
                field.isBezeled = true
            }
        )
    }
}
```

### Upgrade v1 to v2

```diff
import SearchField

struct ContentView: View {
    @State private var searchText = ""
    var body: some View {
-        SearchField(searchText, textFieldChanged: { value in
+        SearchField(searchText: $searchText, placeholder: "Search...") { text in
-            print("value\(value)")
-            searchText = value
+            print("Search text changed to: \(text)")
+        })
-        }
        Text(searchText)
    }
}
```

```swift
import SwiftUI
import SearchField

struct ContentView: View {
    @State private var searchText = ""

    var body: some View {
        SearchField(searchText: $searchText, placeholder: "Search...", searchField:  { text in
            print("Search text changed to: \(text)")
        })
    }
}
```

## License

Licensed under the MIT License.
