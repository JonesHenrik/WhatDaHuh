//
//  wordFoundView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/21/25.
//

import SwiftUI

struct wordFoundView: View {
    var foundWord: Word
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .foregroundStyle(.backgroundWordFoundView)
                .shadow(radius: 8, y: 4)
            VStack {
                HStack {
                    Text(foundWord.title)
                        .font(.title)
                    Spacer()
                    Text(foundWord.date, format: .dateTime.day().month().year())
                        .font(.headline)
                }
                .padding(.top)
                .padding(.horizontal, 40)
                Spacer()
                Text(foundWord.definitions[0])
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    wordFoundView(foundWord: Word(
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
