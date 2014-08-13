//
//  GameScene.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/7/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // Labels - Score and Time
    private var scoreLabel:SKLabelNode = SKLabelNode(fontNamed:GameConstants.FONT_NAME)
    private var timeLabel:SKLabelNode = SKLabelNode(fontNamed:GameConstants.FONT_NAME)
    
    // The bubble create time count.
    private var bubbleCreateTime:Float = 0
    
    // Managers - Time, Score, Bubble.
    private var timeManager:TimeManager = TimeManager(total: GameConstants.DEFAULT_GAME_TIME, interval: 1)
    private var scoreManager:ScoreManager = ScoreManager()
    private var bubbleManager:BubbleManager?
    
    private var uiLayer : SKNode = SKNode()
    private var bubbleLayer : SKNode = SKNode()

    // GameOver Flag
    private var gameOver:Bool = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Initializing the bubble manager.
        bubbleManager = BubbleManager(bounds: CGPoint(x: self.frame.width, y: self.frame.height))
        
        // Creating the labels
        scoreLabel.fontSize = GameConstants.FONT_SIZE
        scoreLabel.position = CGPoint(x:GameConstants.SCREEN_BORDER, y:GameConstants.FONT_SIZE)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        scoreLabel.fontColor = SKColor.blackColor()
        
        timeLabel.fontSize = GameConstants.FONT_SIZE
        timeLabel.position = CGPoint(x:CGRectGetMidX(self.frame) + GameConstants.SCREEN_BORDER, y:GameConstants.FONT_SIZE)
        timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        timeLabel.fontColor = SKColor.blackColor()
        
        // Set background color
        self.backgroundColor = SKColor.whiteColor()
        
        // Set the ui layer position
        uiLayer.zPosition = 1
        
        // Add Layers
        self.addChild(bubbleLayer)
        self.addChild(uiLayer)
        
        // Add labels
        uiLayer.addChild(scoreLabel)
        uiLayer.addChild(timeLabel)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        var score:Bool = bubbleManager!.checkTouch(self, touches: touches)
        if (score) {
            scoreManager.addPoint()
            timeManager.addTime()
        } else {
            scoreManager.subPoint()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        // Update time.
        timeManager.update()
        
        // Update bubbles.
        bubbleManager!.update()
        
        // Show time and score
        timeLabel.text = "Time: " + timeManager.getTime()
        scoreLabel.text = "Score: " + scoreManager.getScore()
        
        // Check if the game is over.
        if (!timeManager.isOver()) {
            
            // If not, create the bubble.
            bubbleCreateTime += GameConstants.UPDATE_TIME
            if (bubbleCreateTime >= GameConstants.BUBBLE_CREATE_TIME) {
                bubbleCreateTime = 0
                bubbleLayer.addChild(bubbleManager!.createBubble())
            }
            
        } else if !gameOver {
            gameOver = true
            
            // DO SOMETHING
            
            
        }
        
    }
}
