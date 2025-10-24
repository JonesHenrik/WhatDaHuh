//
//  CardView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import SwiftUI

struct CardView: View {
    let textShowing: String
    
    var body: some View {
        Text(textShowing)
            .padding(50)
            .background(
                    RoundedRectangle(cornerRadius: 9)
                        .foregroundStyle(.backgroundWordFoundView)
                        .shadow(radius: 8, y: 4)
                        .frame(minWidth: 350, minHeight: 150)
            )
    }
}



#Preview {
    CardView(textShowing:
        "Charisma or charm, especially in romantic situations."
    )
}

