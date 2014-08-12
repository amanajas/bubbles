//
//  TimeManager.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/8/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation
import SpriteKit

class TimeManager {
    
    private var timeInterval:Float?
    private var totalTime:Float = 0
    
    init(total:Float, interval:Float) {
        
        totalTime = total
        timeInterval = interval
    }
    
    func update() {
        
        totalTime -= GameConstants.UPDATE_TIME
        if totalTime < 0 {
            totalTime = 0
        }
        
    }
    
    func addTime(value:Float) {
        totalTime += value
    }
    
    func isOver() -> Bool {
        return totalTime == 0
    }
    
    func getTime() -> String {
        var formatter : NSString = NSString(format: "%.01f", totalTime)
        return formatter.description
    }
}
