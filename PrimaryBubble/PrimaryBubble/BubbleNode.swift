//
//  BubbleNode.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/13/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation
import SpriteKit

class BubbleNode : SKSpriteNode {
    
    
    init(bounds:CGPoint) {
        
    }
    
    /*
    This method creates the bubble including the number
    and the start position.
    */
    private func createBubble() -> SKSpriteNode {
        
        var bubble:SKSpriteNode = SKSpriteNode(texture:textureAtlas.textureNamed("bubble"))
        
        // ------------------------------------------
        // Positioning
        
        let minX = bubble.size.width
        let maxX = bubbleBounds!.x - bubble.size.width / 2
        let rangeX = maxX - minX
        let position:CGFloat = CGFloat(arc4random()) % CGFloat(rangeX) + CGFloat(minX)
        
        bubble.position = CGPointMake(position, -bubble.size.height * 2)
        // ------------------------------------------
        
        // Creating number laber
        var label:SKLabelNode = createNumber()
        
        //Set the bubble´s name the random number
        bubble.name = label.text
        
        // Add child label
        bubble.addChild(label)
        
        // Set bubble action
        let moveAction = SKAction.moveTo(CGPoint(x: position, y: bubbleBounds!.y), duration: GameConstants.BUBBLE_MOVIMENT_TIME)
        bubble.runAction(moveAction)
        
        // Add bubble in the list
        bubbleList.addObject(bubble)
        
        return bubble
        
    }
    
}
