//
//  wordFoundView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/21/25.
//

import SwiftUI

struct wordFoundTileView: View {
    let foundWord: Word
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .foregroundStyle(.backgroundWordFoundView)
                .shadow(radius: 8, y: 4)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(foundWord.title)
                        
                        .font(.title)
                        .padding(.top)
                        .padding(.leading)
                        
                        
                    Spacer()
                    Text(foundWord.date, format: .dateTime.day().month().year())
                        
                        .font(.headline)
                        .padding(.vertical)
                        .padding(.trailing)
                        
                }
                
                
                Spacer()
                Text(foundWord.definitions[0])
                    
                    .padding(.horizontal)
                    .padding(.bottom)
                    .multilineTextAlignment(.leading)
            }
            .foregroundStyle(.text)
        }
        .padding()
    }
}

#Preview {
    wordFoundTileView(foundWord: Word(
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
