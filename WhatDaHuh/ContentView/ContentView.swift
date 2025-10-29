//
//  ContentView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct ContentView: View {
    @State var result = ""
    @State private var vm = ViewModel()
    @State var text = "".lowercased()
    @Environment(\.colorScheme) var colorScheme
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geo in
                    Circle()
                        .foregroundStyle(Color.background)
                        .frame(width: geo.size.width * 2.5,
                               height: geo.size.height * 1.3,
                               alignment: .top)
                        .position(x: geo.size.width / 2, y: geo.size.height / 1000)
                    VStack {
                        HStack {
                            TextField("check slang here", text: $text)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                            Button {
                                isShowingAlert.toggle()
                                result = vm.processInput(text, from: wordBank)
                                text = ""
                            } label: {
                                Text("submit")
                            }
                            .disabled(text == "" ? true : false)
                            .opacity(text == "" ? 0.4 : 1)
                            .foregroundStyle(.white)
                            .underline()
                            .padding()
                            
                        } .alert("\(result)", isPresented: $isShowingAlert) {
                            Button("OK", role: .cancel) {}
                        }
                        Spacer()
                        MainView(vm: $vm)
                        Spacer()
//                        if vm.unlockedTitles.isEmpty {
//                            BadgeProgressView(vm: $vm, badge: Badge(title: "badge name", imageName: "lockedBadge", words: [], description: ""))
//                        } else {
//                            BadgeProgressView(vm: $vm, badge: vm.mostRecentlyUnlockedWord(from: vm.unlockedTitles)?.badge ?? Badge(title: "badge name", imageName: "lockedBadge", words: [], description: ""))
//                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
    
}
