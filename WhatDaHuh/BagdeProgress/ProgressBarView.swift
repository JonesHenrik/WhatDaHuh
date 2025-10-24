//
//  ProgressBarView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var vm: ViewModel
    let badge: Badge
    
    var badgeProgress: CGFloat {
        vm.calculateBadgeProgress(wordsNeeded: badge.words)
    }
    
    var body: some View {
      
            Capsule()
                .foregroundStyle(.thinMaterial)
                .frame(width: 200, height: 30)
                .overlay(
                    HStack {
                        Capsule()
                            .foregroundStyle(Color.progressBar)
                            .frame(width: 200 / badgeProgress, height: 30)
                        Spacer()
                    }
                )
    }
}

#Preview {
    ProgressBarView(vm: .constant(ViewModel()), badge: Badge(
        title: "Glitches",
        imageName: "glitches", words: ["millennial pause", "gen z stare", "we outside", "sending me", "not it"],
        description: "Sample"))
}
