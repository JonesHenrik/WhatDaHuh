//
//  WordView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI
import AVFoundation

struct WordView: View {
    let vm: ViewModel
    let currentWord: Word
    @ScaledMetric(relativeTo: .largeTitle) var imageSize = 400.0

    var cardTexts: [String] {
        switch vm.selectedMode {
        case .definition:
            return currentWord.definitions
        case .example:
            return currentWord.phrases
        }
    }

    var body: some View {
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
                titleAndSoundView(vm: vm, word: currentWord)
                HStack {
                    PickerParentView(vm: vm)
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

                if let badge = currentWord.badge {
                    BadgeProgressView(vm: vm, badge: badge)
                }

                Text("word learned: \(currentWord.date, format: .dateTime.day().month().year())")
            }
        }
    }
}

#Preview {
    WordView(vm: ViewModel(), currentWord: .previewRizz)
}
