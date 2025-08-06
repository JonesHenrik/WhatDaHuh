//
//  BadgeGridView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct BadgeGridView: View {
    @Environment(Router.self) var router
    
    var badges = ["bodega", "campCouture","cerifiedHaters", "certifiedW", "cloutCollector","delulu","dripDivison", "emotionallyDestroyed", "girlEra", "glitches", "maleArch", "meme", "performativeMaleUnion", "podiumTalk", "situationshipSociety","slapScale", "snackSnatchers", "swearSquad", "terminallyOnline", "thirstTrapCert", "toxicTalk" ]
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(badges, id: \.self) { badge in
                        Button {
                            
                        } label: {
                            Image(badge)
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
        }    .frame(maxHeight: 1000)
        
    }
}

#Preview {
    BadgeGridView()
        .environment(Router())
    
}
