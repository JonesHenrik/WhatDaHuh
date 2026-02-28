//
//  wordFoundView.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/21/25.
//

import SwiftUI

struct wordFoundTileView: View {
    let foundWord: Word
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .foregroundStyle(.backgroundWordFoundView)
                .shadow(radius: 8, y: 4)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(foundWord.title)
                        
                        .font(.title)
                        .padding(.top)
                        .padding(.leading)
                        
                        
                    Spacer()
                    Text(foundWord.date, format: .dateTime.day().month().year())
                        
                        .font(.headline)
                        .padding(.vertical)
                        .padding(.trailing)
                        
                }
                
                
                Spacer()
                Text(foundWord.definitions[0])
                    
                    .padding(.horizontal)
                    .padding(.bottom)
                    .multilineTextAlignment(.leading)
            }
            .foregroundStyle(.text)
        }
        .padding()
    }
}

#Preview {
    wordFoundTileView(foundWord: .previewRizz)
}
