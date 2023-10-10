// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(macOS 10.15, *)
public struct SearchField: View {
    @State private var text: String = ""
    var textFieldChanged: ((String) -> Void)
    var value: String
    public init(_ defaultValue: String?, textFieldChanged: @escaping ((String) -> Void)) {
        self.value = defaultValue ?? ""
        self.textFieldChanged = textFieldChanged
    }
    public var body: some View {
        let binding = Binding<String>(
            get: { self.text },
            set: {
                self.text = $0;
                self.textFieldChanged($0)
            }
        )
        return SearchFieldView(search: binding).onAppear {
            text = value
        }
    }
}

@available(macOS 10.15, *)
private struct SearchFieldView: NSViewRepresentable {
    @Binding var search: String
    class Coordinator: NSObject, NSSearchFieldDelegate {
        var parent: SearchFieldView
        init(_ parent: SearchFieldView) {
            self.parent = parent
        }
        func controlTextDidChange(_ notification: Notification) {
//            let searchField = notification.object as! NSSearchField
//            self.parent.search = searchField.stringValue

            guard let searchField = notification.object as? NSSearchField else {
                print("Unexpected control in update notification")
                return
            }
            self.parent.search = searchField.stringValue
        }

    }
    
    func makeNSView(context: NSViewRepresentableContext<SearchFieldView>) -> NSSearchField {
        let tf = NSSearchField(frame: .zero)
//        tf.focusRingType = .none
        tf.drawFocusRingMask()
        return tf
    }
    
    func updateNSView(_ searchField: NSSearchField, context: NSViewRepresentableContext<SearchFieldView>) {
        searchField.stringValue = search
        searchField.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

}
