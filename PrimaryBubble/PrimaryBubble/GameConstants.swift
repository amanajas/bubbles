//
//  GameConstants.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/7/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation
import SpriteKit

 struct GameConstants {
    
    // Maximum speed the bubble moves
    static let MAX_BUBBLES_SPEED:Float = 2
    
    // Speed multiplier used to get a percentage of score value
    static let BUBBLE_SPEED_MULTIPLIER:Float = 0.05
    
    // The Game Font Name
    static let FONT_NAME:String = "System"
    
    // The Game Label font size.
    static let FONT_SIZE:CGFloat = 12.5
    
    // The Game title font size.
    static let TITLE_FONT_SIZE:CGFloat = 40
    
    // The Initial Game Time.
    static let DEFAULT_GAME_TIME:Float = 5
    
    // The Start Game Interval.
    static let START_GAME_INTERVAL:Float = 5
    
    // The Start Game Interval Animation.
    static let START_GAME_INTERVAL_ANIMATION:NSTimeInterval = 1
    
    // The Time Bonus that it's gain when the player hits the prime number.
    static let BONUS_TIME:Float = 4.5
    
    // The range of numbers.
    static let MIN_NUMBER:Int = 2
    static let MAX_NUMBER:Int = 1000
    
    // The update value to decrease time in the game.
    static let UPDATE_TIME:Float = 1 / 60
    
    // The default value to gain when the player hits the prime number.
    static let SCORE_POINT:Int = 10
    
    // The points the user lose when hits the wrong number
    static let SCORE_LOST:Int = 50
    
    // The space between labels and the screen border.
    static let SCREEN_BORDER:CGFloat = 10
    
    // The time to create a new bubble.
    static let BUBBLE_CREATE_TIME:Float = 1.1
    
    // The label font size inside the bubble.
    static let BUBBLE_FONT_SIZE:Float = 25
    
    // The Bubble moviment time to end the path
    static let BUBBLE_MOVIMENT_TIME:Float = 10
    
    // Percent of creation of prime numbers
    static let PRIME_PERCENT:Int = 25
    
    // GameOver screen name
    static let GAMEOVER_SCREEN : String = "OverScreen"
    
    // Bubble explosion frame time
    static let BUBBLE_EXPLOSION_FRAME_TIME : NSTimeInterval = 0.1
}
