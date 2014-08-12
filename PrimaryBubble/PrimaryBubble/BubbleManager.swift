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
    
    // Numbers generator
    private var gameNumbers:GameNumberUtil?
    
    // The list of bubbles to check the touch
    private var bubbleList:NSMutableArray = NSMutableArray()
    
    // The bounds to create and remove the bubbles
    private var bubbleBounds:CGPoint?
    
    
    init(bounds:CGPoint) {
        gameNumbers = GameNumberUtil(min: GameConstants.MIN_NUMBER, max: GameConstants.MAX_NUMBER)
        bubbleBounds = bounds
    }
    
    /*
        This method creates the bubble including the number
        and the start position.
    */
    func createBubble() -> SKSpriteNode {
        
        var bubble:SKSpriteNode = SKSpriteNode(imageNamed: "bubble")
        bubble.physicsBody = SKPhysicsBody(rectangleOfSize: bubble.size)
        bubble.physicsBody.dynamic = true
        bubble.physicsBody.collisionBitMask = 0
        
        let minX = bubble.size.width / 2
        let maxX = bubbleBounds!.x - bubble.size.width / 2
        let rangeX = maxX - minX
        let position:CGFloat = CGFloat(arc4random()) % CGFloat(rangeX) + CGFloat(minX)
        
        bubble.setScale(0.5)
        
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
        
        var numberLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
        numberLabel.fontSize = CGFloat(GameConstants.BUBBLE_FONT_SIZE)
        numberLabel.text = gameNumbers!.getRandomNumber().description
        numberLabel.position = CGPointMake(0, CGFloat(-GameConstants.BUBBLE_FONT_SIZE / 2))
        
        return numberLabel
        
    }
    
    /*
        This method has the responsibility to check if 
        the touch hit in a bubble. If the bubble has a primary number
        it is removed from screen.
    */
    func checkTouch(scene:SKScene, touches: NSSet, withEvent event: UIEvent) -> Bool {
        var score:Bool = false
        for touch: AnyObject in touches {
            let location = touch.locationInNode(scene)
            let touchedNode = scene.nodeAtPoint(location)
            
            for bubble in bubbleList {
                
                if bubble.name == touchedNode.name? {
                    score = gameNumbers!.isPrimary(touchedNode.name.toInt()!)
                    if score {
                        removeBubble(bubble)
                        break;
                    }
                }
            }
            
        }
        return score
    }
    
    private func removeBubble(bubble:AnyObject) {
        bubble.removeFromParent()
        bubbleList.removeObject(bubble)
    }
    
    /*
        This is a generic method that checks some realtime rules.
    */
    func update() {
        
        // Remove bubbles when they reaches the bounds
        for bubble in bubbleList {
            if (bubble.position.y >= bubbleBounds!.y) {
                removeBubble(bubble)
            }
        }
    }
}
