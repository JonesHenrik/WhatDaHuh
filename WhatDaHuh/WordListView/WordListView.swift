//
//  WordListView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct WordListView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        NavigationView {
            Text("Word List View")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigateBackView()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button {
                                // Alphabetize
                            } label: {
                                Text("alphabetize")
                            }
                            Button {
                                // Lowkey gem
                            } label: {
                                Text("lowkey gem 💎")
                            }
                            Button {
                                // old to new
                            } label: {
                                Text("boomer 👴 to alpha 👶")
                            }
                            Button {
                                // new to old
                            } label: {
                                Text("alpha 👶 to boomer 👴")
                            }
                        } label: {
//                            Image(systemName: "slider.horizontal.3")
//                                .accessibilityLabel("Filter Words")
                            ButtonView(sfSymbol: "slider.horizontal.3")
                                .accessibilityLabel("Filter Words")
                        }
                    }
                }
        }
    }
}

#Preview {
    WordListView()
        .environment(Router())
}
