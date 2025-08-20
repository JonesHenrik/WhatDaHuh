//
//  BadgeGridView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct BadgeGridView: View {
    @Environment(Router.self) var router
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(badgeBank) { badge in
                        Button {
                            router.navigate(to: .badge(badge))
                            print(router.path)
                            print(router.path.count)
                  
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
                ToolbarItem(placement: .topBarLeading) {
                    NavigateBackView()
                }
            }
        }   // .frame(maxHeight: 1000)
        
    }
}

#Preview {
    BadgeGridView()
        .environment(Router())
    
}
