//
//  ButtonView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/6/25.
//

import SwiftUI

struct ButtonView: View {
    var sfSymbol: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .foregroundStyle(.buttonBackground)
                    .frame(width: geometry.size.width * 0.33)
                Image(systemName: sfSymbol)
                    .foregroundStyle(.white)
                    .frame(width: geometry.size.width * 0.67)
            }
        }
    }
}

#Preview {
    ButtonView(sfSymbol: "medal")
}
