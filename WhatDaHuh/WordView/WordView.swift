//
//  WordView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI
import AVFoundation


struct WordView: View {
    @Binding var vm: ViewModel
    let currentWord: Word
    @ScaledMetric(relativeTo: .largeTitle) var imageSize = 400.0
    
    var cardTexts: [String] {
        switch vm.definitionIsSelected {
        case true:
            return currentWord.definitions
        case false:
            return currentWord.phrases
        }
    }
    var body: some View {
        NavigationStack {
                ZStack {
                    GeometryReader { geo in
                        Circle()
                            .foregroundStyle(Color.background)
                            .frame(width: geo.size.width * 2,
                                   height: geo.size.height * 2,
                                   alignment: .top)
                            .position(x: geo.size.width / 2, y: geo.size.height / 1.5)
                    }
                    VStack {
                        Spacer()
                        titleAndSoundView(vm: $vm, word: currentWord)
                        HStack {
                            PickerParentView(vm: $vm)
                            Spacer()
                        }
                        TabView {
                            CardView(textShowing: cardTexts[0])
                            
                            if cardTexts.count > 1 {
                                CardView(textShowing: cardTexts[1])
                            }
                        }
                        .tabViewStyle(.page)
                        .padding()
                        .frame(width: imageSize, height: 260)
                        
                        Spacer()
                        
                        BadgeProgressView(vm: $vm, badge: currentWord.badge)
                        
                        Text("word learned: \(currentWord.date, format: .dateTime.day().month().year())")
                        
                }
                
            }
        }
    }
}

#Preview {
    WordView(vm: .constant(ViewModel()), currentWord: Word(
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
        badge: Badge(
            title: "Glitches",
            imageName: "glitches",
            words: ["millennial pause", "gen z stare", "we outside", "sending me", "not it"], description: "mannerisms and ironic detachment"
        ),
        isLowkeyGem: false,
        isUnlocked: false
    ))
}
