//
//  WordListMethods.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/1/25.
//

import Foundation

extension ViewModel {

    // MARK: - Private Helpers

    /// Returns every word in `wordBank` that the user has already unlocked.
    ///
    /// Extracted so that each public method shares a single filter predicate
    /// instead of duplicating it — one place to update if the unlock check changes.
    private func unlockedWords(from wordBank: [Word]) -> [Word] {
        wordBank.filter { unlockedTitles.contains($0.title.lowercased()) }
    }

    /// Builds a lowercased-title → Word dictionary for O(1) lookups.
    ///
    /// Building the dictionary once per call reduces the order-based sort methods
    /// from O(n²) linear scans to a single O(n) pass.
    private func titleLookup(for wordBank: [Word]) -> [String: Word] {
        Dictionary(
            wordBank.map { ($0.title.lowercased(), $0) },
            uniquingKeysWith: { first, _ in first }
        )
    }

    // MARK: - Sort / Filter

    /// Returns all unlocked words sorted A → Z by title.
    ///
    /// `SortDescriptor` uses `localizedStandardCompare` by default, giving
    /// locale-aware, case-insensitive ordering without allocating lowercased
    /// copies on every comparison.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: Alphabetically sorted array of unlocked `Word`s.
    func unlockedWordsAZ(from wordBank: [Word]) -> [Word] {
        unlockedWords(from: wordBank)
            .sorted(using: SortDescriptor(\.title))
    }

    /// Returns unlocked words marked as lowkey gems, sorted A → Z.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: Alphabetically sorted array of unlocked lowkey-gem `Word`s.
    func unlockedLowkeyGemsAZ(from wordBank: [Word]) -> [Word] {
        unlockedWords(from: wordBank)
            .filter(\.isLowkeyGem)
            .sorted(using: SortDescriptor(\.title))
    }

    /// Returns unlocked words in the order they were unlocked, oldest first.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: `Word`s ordered from first unlocked to most recently unlocked.
    func unlockedWordsOldestFirst(from wordBank: [Word]) -> [Word] {
        let lookup = titleLookup(for: wordBank)
        return unlockedOrder.compactMap { lookup[$0] }
    }

    /// Returns unlocked words in reverse unlock order, most recently unlocked first.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: `Word`s ordered from most recently unlocked to oldest.
    func unlockedWordsRecentFirst(from wordBank: [Word]) -> [Word] {
        let lookup = titleLookup(for: wordBank)
        return unlockedOrder.reversed().compactMap { lookup[$0] }
    }

    /// Returns the `Word` matching `title`, ignoring case and surrounding whitespace,
    /// or `nil` if no match exists in `wordBank`.
    ///
    /// The input is normalised once before the scan so the predicate does not
    /// allocate a new string for every element it evaluates.
    ///
    /// - Parameters:
    ///   - title: The word title to look up.
    ///   - wordBank: The full list of `Word` objects to search.
    /// - Returns: The matching `Word`, or `nil`.
    func stringToWord(for title: String, from wordBank: [Word]) -> Word? {
        let query = title.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return wordBank.first { $0.title.lowercased() == query }
    }
}
