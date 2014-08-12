//
//  BubbleManager.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/8/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation
import SpriteKit

class BubbleManager {
    
    // Sprite folder
    let textureAtlas = SKTextureAtlas(named: "bubble")
    
    // Bubble explode action
    private var explodeAction : SKAction?
    
    // Numbers generator
    private var gameNumbers:GameNumberUtil?
    
    // The list of bubbles to check the touch
    private var bubbleList:NSMutableArray = NSMutableArray()
    
    // The bounds to create and remove the bubbles
    private var bubbleBounds:CGPoint?
    
    
    init(bounds:CGPoint) {
        gameNumbers = GameNumberUtil(min: GameConstants.MIN_NUMBER, max: GameConstants.MAX_NUMBER)
        bubbleBounds = bounds
        
        // Srpite to create explosion animation
        var bubbleExploreArray:Array = Array<SKTexture>();
        
        bubbleExploreArray.append(textureAtlas.textureNamed("bubble_explode1"));
        bubbleExploreArray.append(textureAtlas.textureNamed("bubble_explode2"));
        bubbleExploreArray.append(textureAtlas.textureNamed("bubble_explode3"));
        bubbleExploreArray.append(textureAtlas.textureNamed("bubble_explode4"));
        
        let animateAction = SKAction.animateWithTextures(bubbleExploreArray, timePerFrame: 0.1)
        let sequenceAction = SKAction.sequence([animateAction, SKAction.removeFromParent()])
        explodeAction = SKAction.repeatAction(sequenceAction, count: 1)
    }
    
    /*
        This method creates the bubble including the number
        and the start position.
    */
    func createBubble() -> SKSpriteNode {
        
        var bubble:SKSpriteNode = SKSpriteNode(texture:textureAtlas.textureNamed("bubble"))
        bubble.physicsBody = SKPhysicsBody(rectangleOfSize: bubble.size)
        bubble.physicsBody.dynamic = true
        bubble.physicsBody.collisionBitMask = 0
        
        let minX = bubble.size.width / 2
        let maxX = bubbleBounds!.x - bubble.size.width / 2
        let rangeX = maxX - minX
        let position:CGFloat = CGFloat(arc4random()) % CGFloat(rangeX) + CGFloat(minX)
        
        /* 
            THE SCALE OF THE IMAGE
        
            Perhaps the scale can be removed when the images
            are fix to a lower size.
        */
        bubble.setScale(GameConstants.BUBBLE_SCALE)
        // ------------------------------------------
        
        bubble.position = CGPointMake(position, -bubble.size.height * 2)
        
        var label:SKLabelNode = createNumber()
        
        bubble.name = label.text
        
        bubble.addChild(label)
        
        bubbleList.addObject(bubble)
        
        return bubble
        
    }
    
    /*
        Creates a label to show the number inside the bubble.
    */
    private func createNumber() -> SKLabelNode {
        
        var numberLabel:SKLabelNode = SKLabelNode(fontNamed:GameConstants.FONT_NAME)
        numberLabel.fontSize = CGFloat(GameConstants.BUBBLE_FONT_SIZE)
        numberLabel.text = gameNumbers!.getRandomNumber().description
        numberLabel.position = CGPointMake(0, CGFloat(-GameConstants.BUBBLE_FONT_SIZE / 2))
        
        return numberLabel
        
    }
    
    /*
        This method has the responsibility to check if 
        the touch hit in a bubble. If the bubble has a prime number
        it is removed from screen.
    */
    func checkTouch(scene:SKScene, touches: NSSet, withEvent event: UIEvent) -> Bool {
        var score:Bool = false
        for touch: AnyObject in touches {
            let location = touch.locationInNode(scene)
            let touchedNode = scene.nodeAtPoint(location)
            
            for bubble in bubbleList {
                
                if bubble.name == touchedNode.name? {
                    score = gameNumbers!.isPrime(touchedNode.name.toInt()!)
                    let object = bubble as SKSpriteNode
                    if score {
                        bubbleList.removeObject(bubble)
                        object.runAction(explodeAction)
                    } else {
                        
                        // Change texture of the bubble
                        object.texture = textureAtlas.textureNamed("redbubble")
                    }
                    break;
                }
            }
            
        }
        return score
    }
    
    /*
        This is a generic method that checks some realtime rules.
    */
    func update() {
        
        // Remove bubbles when they reaches the bounds
        for bubble in bubbleList {
            if (bubble.position.y >= bubbleBounds!.y) {
                bubble.removeFromParent()
                bubbleList.removeObject(bubble)
            }
        }
    }
}
