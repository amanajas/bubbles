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
    private var startAnimation:SKSpriteNode?
    private var overAnimation:SKSpriteNode?

    // GameOver Flag
    private var gameOver:Bool = false
    
    private var startAction:SKAction?
    
    func createStartAnimation() {
        
        if (startAction == nil) {
            // Start animation
            let textureAtlas = SKTextureAtlas(named:"bubble.atlas")
            
            startAnimation = SKSpriteNode(texture: textureAtlas.textureNamed("start_countdown"))
            overAnimation = SKSpriteNode(texture: textureAtlas.textureNamed("gameover_countdown"))
            
            var animationList:Array = Array<SKTexture>();
            animationList.append(textureAtlas.textureNamed("ready_countdown"));
            animationList.append(textureAtlas.textureNamed("3_countdown"));
            animationList.append(textureAtlas.textureNamed("2_countdown"));
            animationList.append(textureAtlas.textureNamed("1_countdown"));
            animationList.append(textureAtlas.textureNamed("go_countdown"));
            
            // Explosion animation
            let animateAction = SKAction.animateWithTextures(animationList, timePerFrame:GameConstants.START_GAME_INTERVAL_ANIMATION)
            
            // Create the action sequence, after the explosion remove the bubble
            let sequenceAction = SKAction.sequence([animateAction, SKAction.removeFromParent()])
            
            //Repeat this action once
            startAction = SKAction.repeatAction(sequenceAction, count: 1)
            
            let position = CGPoint(x: self.frame.width / 2, y:self.frame.height / 2)
            startAnimation!.position = position
            overAnimation!.position = position
        }
        
        uiLayer.addChild(startAnimation!)
        startAnimation!.runAction(startAction)
       
    }
    
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
        
        // Start animation
        createStartAnimation()
    }
    
    override func touchesBegan(touches: (NSSet!), withEvent event: (UIEvent!)) {
        
        if (!gameOver) {
            var score:Bool = bubbleManager!.checkTouch(self, touches: touches)
            if (score) {
                scoreManager.addPoint()
                timeManager.addTime()
            } else {
                scoreManager.subPoint()
            }
        } else {
            resetGame()
        }
    }
    func getBubbleMovimentSpeed() -> (Float, NSTimeInterval) {
        let calSpeed = GameConstants.BUBBLE_MOVIMENT_TIME - Float(scoreManager.getIntScore()) * GameConstants.BUBBLE_SPEED_MULTIPLIER
        let speed = (calSpeed < GameConstants.MAX_BUBBLES_SPEED ? GameConstants.MAX_BUBBLES_SPEED : calSpeed)
        return (speed, NSTimeInterval(speed))
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if (!gameOver) {
        
            // Update time.
            timeManager.update()
            
            // If already start 
            if (timeManager.isStarted()) {
            
                // Update bubbles.
                bubbleManager!.update()
            
                // Show time and score
                timeLabel.text = "Time: " + timeManager.getTime()
                scoreLabel.text = "Score: " + scoreManager.getScore()
            
                // Check if the game is over.
                if (!timeManager.isOver()) {
                
                    // If not, create the bubble.
                    bubbleCreateTime += GameConstants.UPDATE_TIME
                    let speed = getBubbleMovimentSpeed()
                    if (bubbleCreateTime >= GameConstants.BUBBLE_CREATE_TIME - (speed.0 / 100)) {
                        bubbleCreateTime = 0
                        bubbleLayer.addChild(bubbleManager!.createBubble(speed.1))
                    }
                
                } else if !gameOver {
                
                    callGameOver()
                    
                }
                
            }
            
        }
        
    }
    
    func resetGame() {
        
        bubbleManager!.reset()
        scoreManager.reset()
        timeManager.reset()
        gameOver = false
        overAnimation?.removeFromParent()
        createStartAnimation()
    }
    
    func callGameOver() {
        
        gameOver = true
        
        uiLayer.addChild(overAnimation!)
        
        bubbleManager!.destroyAllBubbles()
        
    }
}
