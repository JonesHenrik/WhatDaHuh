//
//  ViewModel.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/1/25.
//

import Foundation

@Observable
class ViewModel {
    /// A set of lowercased word titles that have been unlocked by the user.
    var unlockedWords: Set<String> = []
    
    /// The file URL where the unlocked words are saved as a JSON array.
    let fileURL: URL = {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("unlockedWords.json")
    }()

    /// Initializes the model and attempts to load unlocked words from disk.
    init() {
        loadUnlockedWords()
    }

    /// Unlocks the given word and persists it if it has not already been unlocked.
    ///
    /// - Parameter word: The `Word` to unlock.
    func unlock(word: Word) {
        unlockedWords.insert(word.title.lowercased())
        saveUnlockedWords()
    }

    /// Returns whether the given word is already unlocked.
    ///
    /// - Parameter word: The `Word` to check.
    /// - Returns: `true` if the word is unlocked; `false` otherwise.
    func isUnlocked(_ word: Word) -> Bool {
        unlockedWords.contains(word.title.lowercased())
    }

    /// Saves the current set of unlocked words to disk as a JSON array.
    ///
    /// This method is called automatically after unlocking a word.
    private func saveUnlockedWords() {
        do {
            let data = try JSONEncoder().encode(Array(unlockedWords))
            try data.write(to: fileURL, options: [.atomicWrite])
        } catch {
            print("❌ Failed to save unlocked words: \(error.localizedDescription)")
        }
    }

    /// Loads the unlocked words from disk, if a saved file exists.
    ///
    /// This method is called automatically during initialization.
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
