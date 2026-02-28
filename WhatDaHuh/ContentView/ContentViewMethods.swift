//
//  ContentViewMethods.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/1/25.
//

import Foundation

// MARK: - Search Result

/// The outcome of a user search submission.
/// The view switches on this to decide which alert to present.
enum SearchResult {
    /// Input didn't match any word, even within one-character tolerance.
    case notFound
    /// Word was found but was already unlocked — no action needed.
    case alreadyUnlocked
    /// A new word was unlocked; no badge was completed.
    case wordUnlocked(Word)
    /// A new word was unlocked, and doing so completed a badge.
    case badgeEarned(Word, Badge)
}

// MARK: - Levenshtein Distance

/// Returns the Levenshtein edit distance between two strings.
///
/// Uses two-row rolling DP: O(m × n) time, O(n) space.
/// Short slang titles keep both dimensions small in practice.
func levenshteinDistance(_ a: String, _ b: String) -> Int {
    let a = Array(a), b = Array(b)
    let m = a.count, n = b.count
    guard m > 0 else { return n }
    guard n > 0 else { return m }

    var prev = Array(0...n)
    var curr = Array(repeating: 0, count: n + 1)

    for i in 1...m {
        curr[0] = i
        for j in 1...n {
            curr[j] = a[i - 1] == b[j - 1]
                ? prev[j - 1]
                : 1 + Swift.min(prev[j], curr[j - 1], prev[j - 1])
        }
        swap(&prev, &curr)
    }
    return prev[n]
}

// MARK: - ViewModel Search Extension

extension ViewModel {

    /// Finds the best match for `input` in `wordBank`.
    ///
    /// Returns an exact (lowercased) match immediately.
    /// Falls back to the first word at Levenshtein distance == 1,
    /// skipping candidates whose length already rules them out.
    private func findMatch(for input: String, in wordBank: [Word]) -> Word? {
        let query = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return nil }

        var closeMatch: Word? = nil
        for word in wordBank {
            let title = word.title.lowercased()
            if title == query { return word }                       // exact — short-circuit
            if closeMatch == nil,
               abs(title.count - query.count) <= 1,                // length shortcut
               levenshteinDistance(query, title) == 1 {
                closeMatch = word
            }
        }
        return closeMatch
    }

    /// Processes a user search submission and returns a `SearchResult`
    /// describing exactly what happened. The view uses this to drive alerts.
    ///
    /// Badge completion is checked *after* `unlock(word:)` so that the
    /// newly unlocked word is already counted in `unlockedTitles`.
    ///
    /// - Parameters:
    ///   - input: Raw text from the TextField.
    ///   - wordBank: The full word list to search against.
    ///   - badgeBank: Passed for call-site clarity; completion uses `wordToBadge` internally.
    func submitSearch(input: String, wordBank: [Word], badgeBank: [Badge]) -> SearchResult {
        guard let matched = findMatch(for: input, in: wordBank) else {
            return .notFound
        }

        let key = matched.title.lowercased()
        guard !unlockedTitles.contains(key) else {
            return .alreadyUnlocked
        }

        unlock(word: matched)   // unlockedTitles now contains `key`

        if let badge = wordToBadge[key],
           badge.isFullyUnlocked(given: unlockedTitles) {
            return .badgeEarned(matched, badge)
        }

        return .wordUnlocked(matched)
    }

    /// Returns the most recently unlocked `Word` from the provided word bank.
    func mostRecentlyUnlockedWord(from wordBank: [Word]) -> Word? {
        guard let latestTitle = unlockedOrder.last else { return nil }
        return wordBank.first { $0.title.lowercased() == latestTitle.lowercased() }
    }
}
