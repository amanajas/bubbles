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
    
    // The Game Font Name
    static let FONT_NAME:String = "Chalkduster"
    
    // The Game Label font size.
    static let FONT_SIZE:CGFloat = 12.5
    
    // The Initial Game Time.
    static let DEFAULT_GAME_TIME:Float = 60
    
    // The Time Bonus that it's gain when the player hits the prime number.
    static let BONUS_TIME:Float = 1.5
    
    // The range of numbers.
    static let MIN_NUMBER:Int = 0
    static let MAX_NUMBER:Int = 1000
    
    // The update value to decrease time in the game.
    static let UPDATE_TIME:Float = 1 / 60
    
    // The default value to gain when the player hits the prime number.
    static let SCORE_POINT:Int = 10
    
    // The points the user lose when hits the wrong number
    static let SCORE_LOST:Int = 2
    
    // The space between labels and the screen border.
    static let SCREEN_BORDER:CGFloat = 10
    
    // The time to create a new bubble.
    static let BUBBLE_CREATE_TIME:Float = 0.2
    
    // The label font size inside the bubble.
    static let BUBBLE_FONT_SIZE:Float = 25
    
    // The default scene gravity
    static let GRAVITY:CGFloat = 0.2
    
}
