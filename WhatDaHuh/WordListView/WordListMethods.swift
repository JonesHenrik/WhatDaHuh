//
//  WordListMethods.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/1/25.
//

import Foundation

extension ViewModel {
    /// Returns a list of all unlocked words, sorted alphabetically from A to Z.
    ///
    /// This method filters the provided word bank to only include words whose titles
    /// exist in the `unlockedWords` set. The resulting list is then sorted by title
    /// in ascending (A–Z) order.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: An alphabetically sorted array of unlocked `Word`s.
    func unlockedWordsAZ(from wordBank: [Word]) -> [Word] {
        wordBank
            .filter { unlockedWords.contains($0.title.lowercased()) }
            .sorted { $0.title.lowercased() < $1.title.lowercased() }
    }

    /// Returns a list of unlocked words that are marked as lowkey gems, sorted alphabetically from A to Z.
    ///
    /// This method filters the provided word bank to only include words that are both:
    /// - present in the `unlockedWords` set, and
    /// - marked with `isLowkeyGem == true`.
    ///
    /// The resulting list is sorted by title in ascending (A–Z) order.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: An alphabetically sorted array of lowkey gem `Word`s that have been unlocked.
    func unlockedLowkeyGemsAZ(from wordBank: [Word]) -> [Word] {
        wordBank
            .filter { unlockedWords.contains($0.title.lowercased()) && $0.isLowkeyGem }
            .sorted { $0.title.lowercased() < $1.title.lowercased() }
    }

    /// Returns a list of unlocked words in the order they were originally unlocked (oldest first).
    ///
    /// This method reads the saved list of unlocked word titles from file storage and finds
    /// the corresponding `Word` objects from the word bank in their original unlock order.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: An array of unlocked `Word`s in the order they were unlocked, from oldest to newest.
    func unlockedWordsOldestFirst(from wordBank: [Word]) -> [Word] {
        guard let data = try? Data(contentsOf: fileURL),
              let titles = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }

        return titles.compactMap { title in
            wordBank.first { $0.title.lowercased() == title.lowercased() }
        }
    }

    /// Returns a list of unlocked words in reverse unlock order (most recently unlocked first).
    ///
    /// This method reads the saved list of unlocked word titles from file storage and finds
    /// the corresponding `Word` objects from the word bank in reverse unlock order.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: An array of unlocked `Word`s sorted from most recently unlocked to oldest.
    func unlockedWordsRecentFirst(from wordBank: [Word]) -> [Word] {
        guard let data = try? Data(contentsOf: fileURL),
              let titles = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }

        return titles.reversed().compactMap { title in
            wordBank.first { $0.title.lowercased() == title.lowercased() }
        }
    }
}
