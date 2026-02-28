//
//  MainView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/6/25.
//

import SwiftUI

// Fixed colors — not adaptive to color scheme.
private let fixedWhite = Color(red: 1.0, green: 1.0, blue: 1.0)
private let fixedBlack = Color(red: 0.0, green: 0.0, blue: 0.0)

struct MainView: View {
    let vm: ViewModel
    @State private var searchText = ""
    @State private var activeAlert: SearchResult?

    var body: some View {
        VStack(spacing: 20) {

            // MARK: Search Row
            HStack(spacing: 10) {
                TextField("enter a word...", text: $searchText)
                    .textFieldStyle(.plain)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(fixedWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(fixedBlack)
                    .tint(fixedBlack)
                    .onSubmit { submitWord() }

                Button { submitWord() } label: {
                    Text("submit")
                        .underline()
                        .foregroundStyle(fixedWhite)
                }
            }
            .padding(.horizontal)
        }
        .toolbar {
            NavigationLink {
                WordListView(vm: vm)
            } label: {
                ButtonView(sfSymbol: "book.pages")
            }
            .padding()

            NavigationLink {
                BadgeGridView()
            } label: {
                ButtonView(sfSymbol: "medal")
            }
            .padding()
        }
        .onAppear {
            print(wordBank.count)
        }
        .alert(alertTitle, isPresented: Binding(
            get: { showAlert },
            set: { _ in activeAlert = nil }
        )) {
            Button("ok") { }
        } message: {
            Text(alertMessage)
        }
    }

    // MARK: - Private Helpers

    private func submitWord() {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let result = vm.submitSearch(input: trimmed, wordBank: wordBank, badgeBank: badgeBank)
        searchText = ""
        if case .alreadyUnlocked = result { return }   // silent — no alert
        activeAlert = result
    }

    private var showAlert: Bool {
        switch activeAlert {
        case .notFound, .wordUnlocked, .badgeEarned: true
        case .alreadyUnlocked, .none:                 false
        }
    }

    private var alertTitle: String {
        switch activeAlert {
        case .notFound:              "word not found"
        case .wordUnlocked:          "you've unlocked a new word"
        case .badgeEarned:           "you earned a badge!"
        case .alreadyUnlocked, .none: ""
        }
    }

    private var alertMessage: String {
        switch activeAlert {
        case .notFound:
            "double check your spelling boomer or hop on TikTok for a bit."
        case .wordUnlocked:
            "check your word list for more info"
        case .badgeEarned(_, let badge):
            "congratulations you have earned the \"\(badge.title)\" badge"
        case .alreadyUnlocked, .none:
            ""
        }
    }
}

#Preview {
    NavigationStack {
        MainView(vm: ViewModel())
    }
}
