//
//  NavigateToView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/6/25.
//

import SwiftUI

struct NavigateToView: View {
    @Environment(Router.self) var router
    
    var destination: Route
    var view: String
    
    var body: some View {
        Button {
            router.navigate(to: destination)
        } label: {
            // Should become the view in the hifi in the future.
            // We are able to build out a view and call in the needed sf symbol
            ButtonView(sfSymbol: view)
        }
    }
}

#Preview {
    NavigateToView(destination: .wordList, view: "book.pages")
        .environment(Router())
}
