//
//  BadgeGridView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct BadgeGridView: View {
    var body: some View {
        NavigationView {
            Text("Badge Grid View")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigateBackView()
                    }
                }
        }
    }
}

#Preview {
    BadgeGridView()
}
