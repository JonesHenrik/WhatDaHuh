//
//  ContentView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            MainView(vm: $vm)
        }
    }
}

//#Preview {
//    ContentView()
//        
//}
