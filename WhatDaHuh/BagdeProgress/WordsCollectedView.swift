//
//  WordsCollectedView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct WordsCollectedView: View {
    @Binding var vm: ViewModel
    let badge: Badge
    
    var wordsFound: Int {
        vm.wordsCollected(wordsNeeded: badge.words)
    }
    var body: some View {
        Text("\(wordsFound)/\(badge.words.count) words collected")
            .font(.body)
    }
}

#Preview {
    WordsCollectedView(vm: .constant(ViewModel()), badge: Badge(
        title: "Glitches",
        imageName: "glitches", words: ["millennial pause", "gen z stare", "we outside", "sending me", "not it"],
        description: "Sample"))
}
