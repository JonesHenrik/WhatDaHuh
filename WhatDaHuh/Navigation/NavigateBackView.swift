//
//  NavigateBackView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/6/25.
//

import SwiftUI

struct NavigateBackView: View {
    @Environment(Router.self) var router
    var color: Color
    
    var body: some View {
        Button {
            router.navigateBack()
        
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundStyle(color)
        }
    }
}

#Preview {
    NavigateBackView(color: .white)
        .environment(Router())
}
