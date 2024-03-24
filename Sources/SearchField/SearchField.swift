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
///         SearchField(searchText, textFieldChanged: { value in
///             print("value\(value)")
///             searchText = value
///         })
///     }
/// }
/// ```
/// 
@available(macOS 10.15, *)
public struct SearchField: View {
    // A binding to a string value
    @Binding private var text: String?
    // A closure that takes a string as input and returns void
    var textFieldChanged: ((String) -> Void)

    /// Initializes a SearchField with a default value and a closure to be called when the text field changes
    public init(_ defaultValue: String?, textFieldChanged: @escaping ((String) -> Void)) {
        _text = .constant(defaultValue ?? "")
        self.textFieldChanged = textFieldChanged
    }
    /// Initializes a SearchField with a binding to a string value and a closure to be called when the text field changes
    public init(_ defaultValue: Binding<String?>, textFieldChanged: @escaping ((String) -> Void)) {
        _text = defaultValue
        self.textFieldChanged = textFieldChanged
    }
    // Defines the body of the SearchField view
    public var body: some View {
        let binding = Binding<String>(
            get: { self.text ?? "" }, // Retrieves the value of the binding
            set: {
                // Sets the value of the binding to the new value
                self.text = $0;
                // Calls the closure with the new value
                self.textFieldChanged($0)
            }
        )
        // Returns a SearchFieldView with the created binding
        return SearchFieldView(search: binding)
    }
}

@available(macOS 10.15, *)
private struct SearchFieldView: NSViewRepresentable {
    // A binding to a string value
    @Binding var search: String
    class Coordinator: NSObject, NSSearchFieldDelegate {
        var parent: SearchFieldView
        init(_ parent: SearchFieldView) {
            self.parent = parent
        }
        // Called when the text in the search field changes
        func controlTextDidChange(_ notification: Notification) {
//            let searchField = notification.object as! NSSearchField
//            self.parent.search = searchField.stringValue

            guard let searchField = notification.object as? NSSearchField else {
                print("Unexpected control in update notification")
                return
            }
            // Sets the binding value to the new search field value
            self.parent.search = searchField.stringValue
        }
    }
    // Creates a new NSView instance
    func makeNSView(context: NSViewRepresentableContext<SearchFieldView>) -> NSSearchField {
        // Creates a new NSSearchField
        let tf = NSSearchField(frame: .zero)
//        tf.focusRingType = .none
        tf.drawFocusRingMask()
        return tf
    }
    
    func updateNSView(_ searchField: NSSearchField, context: NSViewRepresentableContext<SearchFieldView>) {
        // Updates the search field's value with the binding value
        searchField.stringValue = search
        // Sets the coordinator as the search field's delegate
        searchField.delegate = context.coordinator
    }
    
    // 创建一个协调器实例以与 NSView 协调
    // Creates a coordinator instance to coordinate with the NSView
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

}
