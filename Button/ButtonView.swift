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

            ZStack {
                //Capsule()
                 //   .foregroundStyle(.buttonBackground)
                    
                Image(systemName: sfSymbol)
                    
//                    .padding()
            }
            //.padding(.top)
        
    }
}

#Preview {
    ButtonView(sfSymbol: "medal")
}
