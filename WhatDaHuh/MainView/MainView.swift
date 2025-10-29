//
//  MainView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/6/25.
//

import SwiftUI

struct MainView: View {
    @Binding var vm: ViewModel
    
    var body: some View {
        if vm.unlockedTitles.isEmpty {
            Text("Submit words you have found/heard \nto find the definition and earn badges!")
                .foregroundStyle(.text)
                .font(.title2)
        } else {
            NoCircleWordView(vm: $vm, currentWord: vm.mostRecentlyUnlockedWord(from: vm.unlockedTitles) ?? Word(title: "no word", wordClass: "", phoneticSpelling: "", definitions: [], phrases: [], badge: sampleBadge, isLowkeyGem: false, isUnlocked: false))
        
            .toolbar {
                NavigationLink {
                    WordListView(vm: $vm)
                } label: {
                    ButtonView(sfSymbol: "book.pages")
                }
                .padding()
                
                NavigationLink {
                    BadgeGridView()
                } label: {
                    ButtonView(sfSymbol: "medal")
                }
                
                .padding()
            }
            .onAppear {
                print(wordBank.count)
            }
        }
    }
}
#Preview {
    MainView(vm: .constant(ViewModel()))

}

