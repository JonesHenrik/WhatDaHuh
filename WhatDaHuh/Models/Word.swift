//
//  Word.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import Foundation

struct Word {
    let id = UUID()
    var title: String
    var wordClass: String
    var definitions: [String]
    var phrases: [String]
    var badge: Badge
    var date: Date
    // rare in UI should appear as 'lowkey gem'
    var isRare: Bool
}
