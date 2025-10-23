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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
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

#Preview {
    MainView(vm: .constant(ViewModel()))

}
