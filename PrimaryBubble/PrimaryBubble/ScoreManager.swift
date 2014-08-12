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
    
    func addPoint() {
        score += GameConstants.SCORE_POINT
    }
    
    func getScore() -> String {
        return String(score)
    }
}
