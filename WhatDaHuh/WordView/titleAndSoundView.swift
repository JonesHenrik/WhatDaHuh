//
//  titleAndSoundView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI
import AVFoundation


struct titleAndSoundView: View {
    @Binding var vm: ViewModel
    
    let word: Word
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(word.title)
                        .font(.largeTitle)
                    Text("(\(word.wordClass))")
                        .font(.body)
                }
                
                Text(word.phoneticSpelling)
                    .font(.body)
            }
            .foregroundStyle(.white)
            Spacer()
            Button {
                // PlaySound does not work
                vm.textToSpeech(word.title)
            } label: {
                CustomButtonView(sfSymbol: "speaker.wave.3.fill")
            }
        }
        .safeAreaPadding()
    }
}

#Preview {
    titleAndSoundView(vm: .constant(ViewModel()), word: Word(
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
