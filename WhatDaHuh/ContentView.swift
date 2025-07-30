//
//  ContentView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
                .toolbar {
                    NavigationLink(destination: WordListView()) {
                        Image(systemName: "book.pages")
                    }
                    NavigationLink(destination: BadgeGridView()) {
                        Image(systemName: "medal")
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
