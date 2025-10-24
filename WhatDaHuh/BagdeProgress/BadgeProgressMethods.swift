//
//  BadgeProgressMethods.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 10/24/25.
//

import Foundation

extension ViewModel {
    
    func calculateBadgeProgress(wordsNeeded: [String]) -> CGFloat {
        var unlocked = 5
        
        for wordNeeded in wordsNeeded {
            if unlockedTitles.contains(wordNeeded) {
                unlocked -= 1
            }
        }
        
        return CGFloat(unlocked)
    }
    
    func wordsCollected(wordsNeeded: [String]) -> Int {
        var unlocked = 0
        
        for wordNeeded in wordsNeeded {
            if unlockedTitles.contains(wordNeeded) {
                unlocked += 1
            }
        }
        
        return unlocked
    }
}
