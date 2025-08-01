//
//  ViewModel.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/1/25.
//

import Foundation

@Observable
class ViewModel {
    var unlockedWords: Set<String> = []

    private let fileURL: URL = {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("unlockedWords.json")
    }()

    init() {
        loadUnlockedWords()
    }

    func unlock(word: Word) {
        unlockedWords.insert(word.title.lowercased())
        saveUnlockedWords()
    }

    func isUnlocked(_ word: Word) -> Bool {
        unlockedWords.contains(word.title.lowercased())
    }

    private func saveUnlockedWords() {
        do {
            let data = try JSONEncoder().encode(Array(unlockedWords))
            try data.write(to: fileURL, options: [.atomicWrite])
        } catch {
            print("❌ Failed to save unlocked words: \(error.localizedDescription)")
        }
    }

    private func loadUnlockedWords() {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            let titles = try JSONDecoder().decode([String].self, from: data)
            unlockedWords = Set(titles)
        } catch {
            print("❌ Failed to load unlocked words: \(error.localizedDescription)")
        }
    }
}
