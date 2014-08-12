//
//  ScoreManager.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/8/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation

class ScoreManager {
    
    private var score:Int = 0
    
    // Add points to score
    func addPoint() {
        score += GameConstants.SCORE_POINT
    }
    
    // Remove points from score
    func subPoint() {
        score -= GameConstants.SCORE_LOST
        if score < 0 {
            score = 0
        }
    }
    
    // Return score
    func getScore() -> String {
        return String(score)
    }
}
