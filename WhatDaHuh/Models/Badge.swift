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
    
    var image: Image {
            Image(imageName)
        }
}

var sampleBadge = Badge(title: "Sample", imageName: "sample", words: ["rizz", "no cap"])
