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
    @State var text = ""
   var newSampleBadge = Badge(
        title: "Podium Talk",
        imageName: "podiumTalk",
        words: ["podium", "pop your shit", "clock it", "big ups", "shoaaaaa"], description: "main character energy and presence"
    )
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
                            Image(systemName: "magnifyingglass")
                                .padding()
                            TextField("Enter Word", text: $text)
                                .padding()
                            
                            Button {
                                isShowingAlert.toggle()
                               result = vm.processInput(text, from: wordBank)
                            } label: {
                                Text("Submit")
                            }
                            .disabled(text == "" ? true : false)
                            .opacity(text == "" ? 0.4 : 1)
                            .foregroundStyle(.text)
                            .padding()
                            
                        } .alert("\(result)", isPresented: $isShowingAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        Spacer()
                        MainView(vm: $vm)
                        Spacer()
                        HStack(spacing: 40){
                            Image(newSampleBadge.imageName)
                                .resizable()
                                .scaledToFit()
                             
                            VStack {
                                Text("\(newSampleBadge.title)")
                                    .foregroundStyle(.text)
                                Text("\("Progress bar")")
                                
                            }.padding(15)
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
    
}
