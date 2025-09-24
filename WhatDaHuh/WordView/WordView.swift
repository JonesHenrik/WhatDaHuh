//
//  WordView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct WordView: View {
    @Environment(Router.self) var router
    let currentWord: Word
    var body: some View {
        NavigationView {
            Text("Word View")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigateBackView(color: .white)
                    }
                }
        }
    }
}

#Preview {
    WordView(currentWord: Word(
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
