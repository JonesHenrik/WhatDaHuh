//
//  BadgeView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct BadgeView: View {
    @Environment(Router.self) var router
    @Environment(\.colorScheme) var colorScheme
    let currentBadge: Badge
    var body: some View {
        NavigationView {
            VStack {
                currentBadge.image
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("Description")
                    .font(.body)
                    .italic()
                    .padding(.bottom)
                ZStack {
                    GeometryReader { geo in
                        Circle()
                            .foregroundStyle(Color.background)
                            .frame(width: geo.size.width * 2.0,
                                   height: geo.size.width * 1.6,
                                   alignment: .bottom)
                            .position(x: geo.size.width / 2, y: geo.size.height)
                        
                        List(currentBadge.words, id: \.self) { word in
                            Text(word)
                                .font(.body)
                        }
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)
                        .padding()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigateBackView(color: colorScheme == .dark ? .white : .black)
                            .accessibilityLabel("back a view")
                    }
                    ToolbarItem(placement: .principal) {
                        Text("badges")
                            .font(.largeTitle)
                            .accessibilityLabel("badges")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "square.and.arrow.up")
                            .accessibilityLabel("Share badge")
                    }
                }
            }
        }
    }
}
#Preview {
    BadgeView(currentBadge: Badge(title: "Certified W", imageName: "certifiedW", words: ["rizz", "goated", "tuff", "w", "hits"]))
        .environment(Router())
}
