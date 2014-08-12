//
//  GameScene.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/7/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private var scoreLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
    private var timeLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
    
    private var bubbleCreateTime:Float = 0
    
    private var timeManager:TimeManager = TimeManager(total: GameConstants.DEFAULT_GAME_TIME, interval: 1)
    private var scoreManager:ScoreManager = ScoreManager()
    private var bubbleManager:BubbleManager?
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        bubbleManager = BubbleManager(bounds: CGPoint(x: self.frame.width, y: self.frame.height))
        
        scoreLabel.fontSize = GameConstants.FONT_SIZE
        scoreLabel.position = CGPoint(x:GameConstants.SCREEN_BORDER, y:GameConstants.FONT_SIZE)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        timeLabel.fontSize = GameConstants.FONT_SIZE
        timeLabel.position = CGPoint(x:CGRectGetMidX(self.frame) + GameConstants.SCREEN_BORDER, y:GameConstants.FONT_SIZE)
        timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        self.addChild(scoreLabel)
        self.addChild(timeLabel)
        
        self.physicsWorld.gravity = CGVectorMake(0, GameConstants.GRAVITY)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        var score:Bool = bubbleManager!.checkTouch(self, touches: touches, withEvent: event)
        if (score) {
            println("SCORE!!")
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        timeManager.update()
        
        bubbleManager!.update()
        
        timeLabel.text = "Time: " + timeManager.getTime()
        scoreLabel.text = "Score: " + scoreManager.getScore()
        
        if (!timeManager.isOver()) {
            
            bubbleCreateTime += GameConstants.UPDATE_TIME
            if (bubbleCreateTime >= GameConstants.BUBBLE_CREATE_TIME) {
                bubbleCreateTime = 0
                self.addChild(bubbleManager!.createBubble())
            }
            
        }
        
    }
}
