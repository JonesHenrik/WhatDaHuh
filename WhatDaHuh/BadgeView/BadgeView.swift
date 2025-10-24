//
//  BadgeView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct BadgeView: View {
    @Environment(\.colorScheme) var colorScheme
    let currentBadge: Badge
    var body: some View {
        NavigationStack {
            VStack {
                currentBadge.image
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color("shadow") ,radius: 5, x: 0, y: 15)
                    .padding()
                Text(currentBadge.description)
                    .font(.body)
                    .italic()
                    .padding(.bottom)
                ZStack {
                    GeometryReader { geo in
                        Circle()
                            .foregroundStyle(Color.background)
                            .frame(width: geo.size.width * 2.0,
                                   height: geo.size.width * 1.65,
                                   alignment: .bottom)
                            .position(x: geo.size.width / 2, y: geo.size.height)
                        
                        List(currentBadge.fullWords(from: wordBank)) { word in
                            HStack{
                                Text("\(word.title)")
                                    .font(.title2)
                                Spacer()
                                Text("\(word.isLowkeyGem ? "💎" : "")")
                            }
                        
                        }
                        .scrollContentBackground(.hidden)
                        .padding()
                       
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 1.4)
                        .position(x: geo.size.width / 2, y: geo.size.height / 1.4)
                        
                    }
                }
                .toolbar {
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
    BadgeView(currentBadge: Badge(title: "Certified W", imageName: "cloutCollector", words: ["rizz", "goated", "tuff", "w", "hits"], description: "Compliments, wins, and hype"))
}
