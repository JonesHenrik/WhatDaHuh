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
    /// exist in the `unlockedTitles` set. The resulting list is then sorted by title
    /// in ascending (A–Z) order.
    ///
    /// - Parameter wordBank: The full list of available `Word` objects.
    /// - Returns: An alphabetically sorted array of unlocked `Word`s.
    func unlockedWordsAZ(from wordBank: [Word]) -> [Word] {
        wordBank
            .filter { unlockedTitles.contains($0.title.lowercased()) }
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
            .filter { unlockedTitles.contains($0.title.lowercased()) && $0.isLowkeyGem }
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
    
    func stringToWord(for title: String) -> Word? {
        return wordBank.first {
            $0.title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            == title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    // MARK: - Badge title resolution for displaying words and gem indicators
    
    /// Normalizes a title for matching: lowercase, trimmed, with curly quotes converted to straight.
    func normalizeTitle(_ raw: String) -> String {
        let lowered = raw.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // Replace common curly apostrophes/quotes with straight equivalents
        let mapped = lowered
            .replacingOccurrences(of: "’", with: "'")
            .replacingOccurrences(of: "‘", with: "'")
            .replacingOccurrences(of: "“", with: "\"")
            .replacingOccurrences(of: "”", with: "\"")
        return mapped
    }
    
    /// Known variant spellings mapped to canonical WordBank titles (all matching done lowercased).
    var variantMap: [String: String] {
        [
            "ashton hall": "aston hall",
            "what da helly": "what the helly",
            "roger nooo": "roger no",
            "lip pillow": "lip pillows"
            // Note: "don’t forget the bev" becomes "don't forget the bev" via normalizeTitle
        ]
    }
    
    /// Resolves a single badge string to a Word in the global wordBank, accounting for normalization and variants.
    func resolveBadgeTitle(_ raw: String) -> Word? {
        let norm = normalizeTitle(raw)
        let canonical = variantMap[norm] ?? norm
        return wordBank.first { normalizeTitle($0.title) == canonical }
    }
    
    /// Resolves all words for a badge (preserving order), skipping any that cannot be matched.
    func words(for badge: Badge, from wordBank: [Word]) -> [Word] {
        badge.words.compactMap { resolveBadgeTitle($0) }
    }
}

