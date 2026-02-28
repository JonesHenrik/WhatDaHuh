//
//  Word.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import Foundation

struct Word: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var wordClass: String
    var phoneticSpelling: String
    var definitions: [String]
    var phrases: [String]
    var date = Date.now

    /// Resolved from `wordToBadge` — `BadgeBank` is the single source of truth for membership.
    var badge: Badge? { wordToBadge[title.lowercased()] }
    // rare in UI should appear as 'lowkey gem'
    var isLowkeyGem: Bool
    var isUnlocked: Bool
}
