//
//  ViewModel.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/1/25.
//

import Foundation

@MainActor
@Observable
class ViewModel {

    // MARK: - Card Mode

    /// Controls which card content is shown in WordView.
    enum CardMode { case definition, example }
    var selectedMode: CardMode = .definition

    // MARK: - Unlocked Words

    /// A set of lowercased word titles that have been unlocked by the user.
    var unlockedTitles: Set<String> = []

    /// Ordered list of unlocked word titles, from oldest to newest unlock.
    var unlockedOrder: [String] = []

    /// The file URL where the unlocked words are saved as a JSON array.
    let fileURL: URL

    /// Initializes the model using the app's Documents directory for persistence.
    init() {
        self.fileURL = URL.documentsDirectory.appending(path: "unlockedWords.json")
        loadUnlockedWords()
    }

    /// Initializes the model with a custom persistence URL.
    /// Use this in unit tests to write to a temporary location
    /// instead of the real Documents directory.
    init(fileURL: URL) {
        self.fileURL = fileURL
        loadUnlockedWords()
    }

    /// Unlocks the given word and persists it if it has not already been unlocked.
    ///
    /// - Parameter word: The `Word` to unlock.
    func unlock(word: Word) {
        let title = word.title.lowercased()
        guard !unlockedTitles.contains(title) else { return }
        unlockedTitles.insert(title)
        unlockedOrder.append(title)
        saveUnlockedWords()
    }

    /// Returns whether the given word is already unlocked.
    ///
    /// - Parameter word: The `Word` to check.
    /// - Returns: `true` if the word is unlocked; `false` otherwise.
    func isUnlocked(_ word: Word) -> Bool {
        unlockedTitles.contains(word.title.lowercased())
    }

    /// Saves the current ordered list of unlocked words to disk as a JSON array.
    ///
    /// This method is called automatically after unlocking a word.
    private func saveUnlockedWords() {
        do {
            let data = try JSONEncoder().encode(unlockedOrder)
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
            unlockedOrder = titles
            unlockedTitles = Set(titles)
        } catch {
            print("❌ Failed to load unlocked words: \(error.localizedDescription)")
        }
    }
}
