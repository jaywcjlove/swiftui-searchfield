//
//  ContentView.swift
//  SearchFieldExample
//
//  Created by 王楚江 on 2023/10/10.
//

import SwiftUI
import SearchField

struct ContentView: View {
    @State private var searchText = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Search Field!")
            SearchField(searchText, textFieldChanged: { value in
                print("value\(value)")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
