//
//  Badge.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import Foundation
import SwiftUI

struct Badge: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var imageName: String
    var words: [String]
    var description: String
    
    var image: Image {
            Image(imageName)
        }
}
extension Badge {
    func fullWords(from wordBank: [Word]) -> [Word] {
        wordBank.filter { words.contains($0.title) }
    }
}
var sampleBadge = Badge(title: "Sample", imageName: "sample", words: ["rizz", "no cap"], description: "Sample")
