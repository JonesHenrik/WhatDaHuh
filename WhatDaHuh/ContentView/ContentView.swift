//
//  ContentView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()
    @State private var vm = ViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            MainView(vm: $vm)
                .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .main:
                            MainView(vm: $vm)
                                .navigationBarBackButtonHidden(true)
                        case .word(let word):
                            WordView(currentWord: word)
                                .navigationBarBackButtonHidden(true)
                        case .wordList:
                            WordListView(vm: $vm)
                                .navigationBarBackButtonHidden(true)
                        case .badge(let badge):
                               BadgeView(currentBadge: badge)
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
