//
//  WordListView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

private enum SortMode {
    case alphabetical, lowkeyGem, oldestFirst, recentFirst
}

struct WordListView: View {
    let vm: ViewModel
    @State private var sortMode: SortMode = .alphabetical

    private var displayedWords: [Word] {
        switch sortMode {
        case .alphabetical: vm.unlockedWordsAZ(from: wordBank)
        case .lowkeyGem:    vm.unlockedLowkeyGemsAZ(from: wordBank)
        case .oldestFirst:  vm.unlockedWordsOldestFirst(from: wordBank)
        case .recentFirst:  vm.unlockedWordsRecentFirst(from: wordBank)
        }
    }

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
                if !displayedWords.isEmpty {
                    ScrollView {
                        ForEach(displayedWords) { word in
                            NavigationLink(destination: WordView(vm: vm, currentWord: word)) {
                                wordFoundTileView(foundWord: word)
                            }
                        }
                    }
                } else {
                    Text("words and definitions will appear here after submission!")
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
                        sortMode = .alphabetical
                    } label: {
                        Text("alphabetize")
                    }
                    Button {
                        sortMode = .lowkeyGem
                    } label: {
                        Text("lowkey gem 💎")
                    }
                    Button {
                        sortMode = .oldestFirst
                    } label: {
                        Text("boomer 👴 to alpha 👶")
                    }
                    Button {
                        sortMode = .recentFirst
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
