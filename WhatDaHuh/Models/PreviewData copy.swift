//
//  PreviewData.swift
//  WhatDaHuh
//
//  Static fixtures for SwiftUI previews.
//  Wrapped in #if DEBUG so they are never compiled into release builds.
//

#if DEBUG
extension Word {
    /// "rizz" — used to preview word-related views.
    static let previewRizz = Word(
        title: "rizz",
        wordClass: "noun",
        phoneticSpelling: "riz",
        definitions: [
            "Charisma or charm, especially in romantic situations.",
            "The ability to attract or flirt effectively."
        ],
        phrases: [
            "He's got that unspoken rizz.",
            "You need better rizz if you're gonna talk to them."
        ],
        isLowkeyGem: false,
        isUnlocked: false
    )
}

extension Badge {
    /// "Certified W" — used to preview BadgeView.
    static let previewCertifiedW = Badge(
        title: "Certified W",
        imageName: "cloutCollector",
        words: ["rizz", "goated", "tuff", "w", "hits"],
        description: "Compliments, wins, and hype"
    )

    /// "Glitches" — used to preview badge progress views.
    static let previewGlitches = Badge(
        title: "Glitches",
        imageName: "glitches",
        words: ["millennial pause", "gen z stare", "we outside", "sending me", "not it"],
        description: "Sample"
    )
}
#endif
