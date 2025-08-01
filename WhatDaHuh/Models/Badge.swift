//
//  Badge.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import Foundation
import SwiftUI

struct Badge {
    var title: String
    var image: Image
    var words: [String]
}

var sampleBadge = Badge(title: "Sample", image: Image(.sample), words: ["rizz", "no cap"])
