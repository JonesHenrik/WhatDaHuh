//
//  WordListView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct WordListView: View {
    let vm: ViewModel

    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in
                    Circle()
                        .foregroundStyle(Color.background)
                        .frame(width: geo.size.width * 1.5,
                               height: geo.size.height * 1.4,
                               alignment: .top)
                        .position(x: geo.size.width / 2, y: geo.size.height / 10000)
                }
                if !vm.unlockedTitles.isEmpty {
                    ScrollView {
                        ForEach(Array(vm.unlockedTitles), id: \.self) { title in
                            if let word = vm.stringToWord(for: title) {
                                NavigationLink(value: word) {
                                    wordFoundTileView(foundWord: word)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Word.self) { word in
                        WordView(vm: vm, currentWord: word)
                    }
                } else {
                    Text("words and definitions will appear here after submition!")
                        .multilineTextAlignment(.center)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("words found")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .accessibilityLabel("words found")
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
                    ButtonView(sfSymbol: "slider.horizontal.3")
                        .accessibilityLabel("Filter Words")
                }
            }
        }
    }
}

#Preview {
    WordListView(vm: ViewModel())
}
