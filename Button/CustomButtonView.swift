//
//  CustomButtonView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct CustomButtonView: View {
    let sfSymbol: String
    var body: some View {
        ButtonView(sfSymbol: sfSymbol)
            .padding()
            .background(Color.volumeButtonBackground)
            .foregroundStyle(.white)
            .clipShape(Circle())
    }
}

#Preview {
    CustomButtonView(sfSymbol: "medal")
}
