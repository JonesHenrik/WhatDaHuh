//
//  Badge.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import Foundation

struct Badge: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var imageName: String
    var words: [String]
    var description: String
}

extension Badge {
    /// Returns `true` if every word in this badge has been unlocked.
    ///
    /// - Parameter unlockedTitles: The set of lowercased word titles the user has unlocked.
    ///   Pass `ViewModel.unlockedTitles` at the call site.
    func isFullyUnlocked(given unlockedTitles: Set<String>) -> Bool {
        words.allSatisfy { unlockedTitles.contains($0.lowercased()) }
    }

    /// The image name to display: the badge's own image when fully unlocked,
    /// or `"lockedBadge"` if any word is still missing.
    func displayImageName(given unlockedTitles: Set<String>) -> String {
        isFullyUnlocked(given: unlockedTitles) ? imageName : "lockedBadge"
    }
}

