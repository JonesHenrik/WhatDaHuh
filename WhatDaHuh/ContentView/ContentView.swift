//
//  ContentView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            MainView()
                .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .main:
                            MainView()
                                .navigationBarBackButtonHidden(true)
                        case .word:
                            WordView()
                                .navigationBarBackButtonHidden(true)
                        case .wordList:
                            WordListView()
                                .navigationBarBackButtonHidden(true)
                        case .badge:
                            BadgeView()
                                .navigationBarBackButtonHidden(true)
                        case .badgeGrid:
                            BadgeGridView()
                                .navigationBarBackButtonHidden(true)
                    }
                }
        }
        .environmentObject(router)
    }
}

//#Preview {
//    ContentView()
//        .environment(Router())
//}
