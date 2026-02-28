//
//  WordsCollectedView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct WordsCollectedView: View {
    let vm: ViewModel
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
    WordsCollectedView(vm: ViewModel(), badge: .previewGlitches)
}
