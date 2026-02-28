//
//  Badge.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import Foundation

struct Badge: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var imageName: String
    var words: [String]
    var description: String
}

