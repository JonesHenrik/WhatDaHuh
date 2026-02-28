//
//  BadgeProgressView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct BadgeProgressView: View {
    let vm: ViewModel
    let badge: Badge

    var body: some View {
        HStack {
            Image("\(badge.imageName)")
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 125)
            VStack(alignment: .leading) {
                Text("\(badge.title)")
                    .font(.largeTitle)

                ProgressBarView(vm: vm, badge: badge)
                WordsCollectedView(vm: vm, badge: badge)
            }
        }
        .safeAreaPadding()
    }
}

#Preview {
    BadgeProgressView(vm: ViewModel(), badge: .previewGlitches)
}
