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
    private var startTime:Float = 0
    private var initTime:Float = 0
    
    init(total:Float, interval:Float) {
        
        initTime = total + GameConstants.START_GAME_INTERVAL
        timeInterval = interval
        reset()
    }
    
    func update() {
        
        startTime = startTime > 0 ? startTime - GameConstants.UPDATE_TIME : 0
        
        if (isStarted()) {
            totalTime = totalTime > 0 ? totalTime - GameConstants.UPDATE_TIME : 0
        }
        
    }
    
    func addTime() {
        totalTime += GameConstants.BONUS_TIME
    }
    
    func isOver() -> Bool {
        return totalTime == 0
    }
    
    func isStarted() -> Bool {
        return startTime <= 1
    }
    
    func getStartTime() -> String {
        var formatter : NSString = NSString(format: "%.01f", startTime)
        return formatter.description
    }
    
    func getTime() -> String {
        var formatter : NSString = NSString(format: "%.01f", totalTime)
        return formatter.description
    }
    
    func reset() {
        totalTime = initTime
        startTime = GameConstants.START_GAME_INTERVAL
    }
}
