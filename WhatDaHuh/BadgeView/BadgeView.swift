//
//  BadgeView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct BadgeView: View {
    var body: some View {
        NavigationView {
            Text("Badge View")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigateBackView()
                    }
                }
        }
    }
}

#Preview {
    BadgeView()
}
