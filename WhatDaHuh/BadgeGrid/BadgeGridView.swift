//
//  BadgeGridView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct BadgeGridView: View {
    @Environment(\.colorScheme) var colorScheme
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(badgeBank) { badge in
                        NavigationLink {
                            BadgeView(currentBadge: badge)
                        } label: {
                            badge.image
                                .resizable()
                                .scaledToFit()
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("badges")
                        .font(.largeTitle)
                }
            }
        }
        
    }
}

#Preview {
    BadgeGridView()
}
