// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// The search input box component can be placed in a non-specific location and is consistent with the default search input box style.
///
/// ## Example
///
/// ```swift
/// import SearchField
///
/// struct ContentView: View {
///     @State private var searchText = ""
///     var body: some View {
///         SearchField(searchText: $searchText, placeholder: "Search...", searchField: { searchField in
///             print(type(of: searchField)) // -> NSSearchField
///         })
///     }
/// }
/// ```
///

@available(macOS 10.15, *)
public struct SearchField: View {
    @Binding private var text: String
    var placeholder: String?
    var onEditingChanged: ((Bool) -> Void)?
    var onTextChanged: ((String) -> Void)?
    var searchField: ((NSSearchField) -> Void)?

    public init(
        searchText: Binding<String>,
        placeholder: String? = nil,
        onEditingChanged: ((Bool) -> Void)? = nil,
        onTextChanged: ((String) -> Void)? = nil,
        searchField: ((NSSearchField) -> Void)? = nil
    ) {
        self._text = searchText
        self.placeholder = placeholder
        self.onEditingChanged = onEditingChanged
        self.onTextChanged = onTextChanged
        self.searchField = searchField
    }

    public var body: some View {
        SearchFieldView(
            search: $text,
            placeholder: placeholder,
            onEditingChanged: onEditingChanged,
            onTextChanged: onTextChanged,
            searchField: searchField
        )
    }
}

@available(macOS 10.15, *)
private struct SearchFieldView: NSViewRepresentable {
    // A binding to a string value
    @Binding var search: String
    var placeholder: String?
    var onEditingChanged: ((Bool) -> Void)?
    var onTextChanged: ((String) -> Void)?
    var searchField: ((NSSearchField) -> Void)?
    
    class Coordinator: NSObject, NSSearchFieldDelegate {
        var parent: SearchFieldView
        init(_ parent: SearchFieldView) {
            self.parent = parent
        }
        // Called when the text in the search field changes
        func controlTextDidChange(_ notification: Notification) {
            guard let searchField = notification.object as? NSSearchField else { return }
            parent.search = searchField.stringValue
            parent.onTextChanged?(searchField.stringValue)
        }
        
        func controlTextDidBeginEditing(_ notification: Notification) {
            parent.onEditingChanged?(true)
        }
        
        func controlTextDidEndEditing(_ notification: Notification) {
            parent.onEditingChanged?(false)
        }
    }

    func makeNSView(context: NSViewRepresentableContext<SearchFieldView>) -> NSSearchField {
        let searchField = NSSearchField(frame: .zero)
        // Sets the coordinator as the search field's delegate
        searchField.delegate = context.coordinator
        searchField.placeholderString = placeholder
        
        // Pass the NSSearchField instance to the external closure.
        self.searchField?(searchField)
        
        return searchField
    }
    
    func updateNSView(_ searchField: NSSearchField, context: NSViewRepresentableContext<SearchFieldView>) {
        searchField.stringValue = search
        searchField.placeholderString = placeholder
    }

    // Creates a coordinator instance to coordinate with the NSView
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
