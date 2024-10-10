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
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Search Field!")
            
            SearchField(searchText: $searchText, placeholder: "Search...", searchField: { searchField in
                print(type(of: searchField)) // -> NSSearchField
            })
            
            SearchField(
                searchText: $searchText,
                placeholder: "Search...",
                searchField: { field in
                    // 自定义 NSSearchField 的属性
                    field.isBordered = true
                    field.isBezeled = true
                }
            )
            
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
            
            SearchField(searchText: $searchText, placeholder: "Search...", searchField:  { text in
                print("Search text changed to: \(text)")
            })
            
            Text(searchText)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
