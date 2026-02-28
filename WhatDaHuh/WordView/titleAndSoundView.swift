//
//  titleAndSoundView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI
import AVFoundation

struct titleAndSoundView: View {
    let vm: ViewModel
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
    titleAndSoundView(vm: ViewModel(), word: .previewRizz)
}
