//
//  WordListView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct WordListView: View {
    @Binding var vm: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    GeometryReader { geo in
                        Circle()
                            .foregroundStyle(Color.background)
                            .frame(width: geo.size.width * 1.5,
                                   height: geo.size.height * 1.4,
                                   alignment: .top)
                            .position(x: geo.size.width / 2, y: geo.size.height / 10000)
                        
                        if !vm.unlockedTitles.isEmpty {
                            ScrollView {
                                ForEach(Array(vm.unlockedTitles), id: \.self) { word in
                                    NavigationLink {
                                        if let newWord = vm.stringToWord(for: word) {
                                            WordView(currentWord: newWord)
                                        }
                                    } label: {
                                        if let newWord = vm.stringToWord(for: word) {
                                            wordFoundTileView(foundWord: newWord)
                                        }
                                    }
                                }
                            }
                        } else {
                            Text("words and definitions will appear here after submition!")
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("words found")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .accessibilityLabel("words found")
                }
//                ToolbarItem(placement: .topBarLeading) {
//                    NavigateBackView(color: .white)
//                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            // Alphabetize
                        } label: {
                            Text("alphabetize")
                        }
                        Button {
                            // Lowkey gem
                        } label: {
                            Text("lowkey gem 💎")
                        }
                        Button {
                            // old to new
                        } label: {
                            Text("boomer 👴 to alpha 👶")
                        }
                        Button {
                            // new to old
                        } label: {
                            Text("alpha 👶 to boomer 👴")
                        }
                    } label: {
                        //                            Image(systemName: "slider.horizontal.3")
                        //                                .accessibilityLabel("Filter Words")
                        ButtonView(sfSymbol: "slider.horizontal.3")
                            .accessibilityLabel("Filter Words")
                    }
                }
            }
        }
    }
}

#Preview {
    WordListView(vm: .constant(ViewModel()))

}
