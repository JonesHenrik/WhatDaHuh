//
//  BadgeView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct BadgeView: View {
    @Environment(Router.self) var router
    let currentBadge: Badge
    var body: some View {
        NavigationView {
            VStack {
                Text("Badge View")
                Text(currentBadge.title)
                currentBadge.image
                    .resizable()
                    .scaledToFit()
            }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigateBackView()
                    }
                }
        }
    }
}

#Preview {
    BadgeView(currentBadge: Badge(title: "", imageName: "certifiedW", words: [""]))
        .environment(Router())
}
