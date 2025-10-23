//
//  PracticeWordView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/23/25.
//

import SwiftUI

struct PracticeWordView: View {
    let word: Word
    var body: some View {
        NavigationStack {
            Text("\(word.title) View")
        }
    }
}

#Preview {
    PracticeWordView(word: Word(
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
        badge: sampleBadge,
        isLowkeyGem: false,
        isUnlocked: false
    ))
}
