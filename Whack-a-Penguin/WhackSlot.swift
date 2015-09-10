//
//  WhackSlot.swift
//  Whack-a-Penguin
//
//  Created by Yohannes Wijaya on 9/10/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    
    // MARK: - Stored Properties
    
    var penguineImageSpriteNode: SKSpriteNode!
    
    // MARK: - Local Methods
    
    func configureHoleAtPosition(coordinate: CGPoint) {
        self.position = coordinate
        
        let spriteNode = SKSpriteNode(imageNamed: "whackHole")
        self.addChild(spriteNode)
        
        let croppingMaskNodeToHidePenguin = SKCropNode()
        croppingMaskNodeToHidePenguin.position = CGPoint(x: 0, y: 15)
        croppingMaskNodeToHidePenguin.zPosition = 1
        croppingMaskNodeToHidePenguin.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        self.penguineImageSpriteNode = SKSpriteNode(imageNamed: "penguinGood")
        self.penguineImageSpriteNode.name = "character"
        self.penguineImageSpriteNode.position = CGPoint(x: 0, y: -90)
        
        croppingMaskNodeToHidePenguin.addChild(self.penguineImageSpriteNode)
        self.addChild(croppingMaskNodeToHidePenguin)
    }
}
