//
//  MainView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/6/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var router: Router
    @Binding var vm: ViewModel
    
    var body: some View {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
                .toolbar {
                    NavigateToView(destination: .wordList, view: "book.pages")
                    NavigateToView(destination: .badgeGrid, view: "medal")
                }
                .onAppear {
                    print(wordBank.count)
                }
    }
}

//#Preview {
//    MainView()
//        .environment(Router())
//}
