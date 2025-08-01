//
//  WordListView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct WordListView: View {
    var body: some View {
        NavigationStack {
            Text("Word List View")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
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
                            Image(systemName: "slider.horizontal.3")
                                .accessibilityLabel("Filter Words")
                        }
                    }
                }
        }
    }
}

#Preview {
    WordListView()
}
