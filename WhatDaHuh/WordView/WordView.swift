//
//  WordView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct WordView: View {
    @Environment(Router.self) var router
    
    var body: some View {
        NavigationView {
            Text("Word View")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigateBackView(color: .white)
                    }
                }
        }
    }
}

#Preview {
    WordView()
}
