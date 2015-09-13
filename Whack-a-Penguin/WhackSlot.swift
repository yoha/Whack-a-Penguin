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
    var isPenguinVisible = false
    var isPenguinHit = false
    
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
    
    func showPenguin(hideTime hideTime: Double) {
        if self.isPenguinVisible { return }
        
        self.penguineImageSpriteNode.xScale = 1.0
        self.penguineImageSpriteNode.yScale = 1.0
        
        self.penguineImageSpriteNode.runAction(SKAction.moveByX(0, y: 80, duration: 0.05))
        self.isPenguinVisible = true
        self.isPenguinHit = false
        
        if RandomInt(min: 0, max: 2) == 0 {
            self.penguineImageSpriteNode.texture = SKTexture(imageNamed: "penguinGood")
            self.penguineImageSpriteNode.name = "charFriend"
        }
        else {
            self.penguineImageSpriteNode.texture = SKTexture(imageNamed: "penguinEvil")
            self.penguineImageSpriteNode.name = "charEnemy"
        }
        
        runAfterDelay(hideTime * 3.5, block: { [unowned self] in self.hidePenguin() })
    }
    
    func hidePenguin() {
        if !self.isPenguinVisible { return }
        
        self.penguineImageSpriteNode.runAction(SKAction.moveByX(0, y: -80, duration: 0.05))
        self.isPenguinVisible = false
    }
    
    func hitPenguin() {
        self.isPenguinHit = true
        
        let delay = SKAction.waitForDuration(0.25)
        let hidePenguin = SKAction.moveByX(0, y: -80, duration: 0.5)
        let notVisible = SKAction.runBlock({ [unowned self] in self.isPenguinVisible = false })
        self.penguineImageSpriteNode.runAction(SKAction.sequence([delay, hidePenguin, notVisible]))
    }
}
