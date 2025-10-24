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
                    
        Image(systemName: sfSymbol)
            

        
    }
}

#Preview {
    ButtonView(sfSymbol: "medal")
}
