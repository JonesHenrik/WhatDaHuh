//
//  ContentViewMethods.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/1/25.
//

import Foundation

extension ViewModel {
    /// Attempts to match user-entered text to a word in the provided word bank.
    ///
    /// This method trims and lowercases the input, then checks if it matches the `title`
    /// of any `Word` in the given word bank. If a match is found and the word isn't already
    /// unlocked, the word will be added to the `unlockedWords` set and saved to disk.
    ///
    /// - Parameters:
    ///   - input: The raw string entered by the user in a `TextField`.
    ///   - wordBank: The full list of available `Word` objects to check against.
    ///
    /// Example usage:
    /// ```swift
    /// unlockModel.processInput(" Deadass ", from: wordBank)
    /// // If "deadass" exists in the wordBank, it will be unlocked
    /// ```
    ///
    /// - Note: Matching is case-insensitive and ignores leading/trailing whitespace.
    /// If no matching word is found, this method does nothing.
    func processInput(_ input: String, from wordBank: [Word]) {
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        guard let matchedWord = wordBank.first(where: { $0.title.lowercased() == trimmedInput }) else {
            print("❌ No matching word found in wordBank.")
            return
        }
        
        if !unlockedWords.contains(matchedWord.title.lowercased()) {
            unlock(word: matchedWord)
            print("✅ Unlocked: \(matchedWord.title)")
        } else {
            print("🔓 Word already unlocked: \(matchedWord.title)")
        }
    }
    
    /// Returns the most recently unlocked `Word` from the provided word bank,
    /// based on the order the titles were added to the unlockedWords set.
    ///
    /// - Parameter wordBank: The static list of all `Word` objects.
    /// - Returns: The most recently unlocked `Word`, or `nil` if none match.
    ///
    /// - Note: This works based on the order in which the unlocked words are saved
    /// to disk and assumes newer ones are appended last. If `Set` ordering is not reliable,
    /// consider switching to a `[String]` to track order explicitly.
    func mostRecentlyUnlockedWord(from wordBank: [Word]) -> Word? {
        // Try loading ordered titles from file directly
        guard let data = try? Data(contentsOf: fileURL),
              let titles = try? JSONDecoder().decode([String].self, from: data),
              let latestTitle = titles.last else {
            return nil
        }
        
        return wordBank.first { $0.title.lowercased() == latestTitle.lowercased() }
    }
}
