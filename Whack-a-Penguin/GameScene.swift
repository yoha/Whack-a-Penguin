//
//  GameScene.swift
//  Whack-a-Penguin
//
//  Created by Yohannes Wijaya on 9/10/15.
//  Copyright (c) 2015 Yohannes Wijaya. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Stored Properties
    
    var gameScoreLabelNode: SKLabelNode!
    var whackSlotArray = [WhackSlot]()
    var penguinPopupTime = 0.85
    var numberOfGameRounds = 0
    
    // MARK: - Computed Properties
    
    var gameScore: Int = 0 {
        didSet { self.gameScoreLabelNode.text = "Score: \(gameScore)" }
    }
    
    // MARK: - Methods Override
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let backgroundSpriteNode = SKSpriteNode(imageNamed: "whackBackground")
        backgroundSpriteNode.position = CGPoint(x: 512, y: 384)
        backgroundSpriteNode.blendMode = SKBlendMode.Replace
        self.addChild(backgroundSpriteNode)
        
        self.gameScoreLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        self.gameScoreLabelNode.text = "Score: 0"
        self.gameScoreLabelNode.position = CGPoint(x: 8, y: 8)
        self.gameScoreLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        self.gameScoreLabelNode.fontSize = 48.0
        self.addChild(self.gameScoreLabelNode)
        
        // Slots and penguins
        for i in 0 ..< 5 { self.createSlotAt(CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { self.createSlotAt(CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { self.createSlotAt(CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { self.createSlotAt(CGPoint(x: 180 + (i * 170), y: 140)) }
        
        runAfterDelay(1.0, block: { [unowned self] in self.createPenguin() })
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        let nodes = self.nodesAtPoint(touchLocation)
        
        for node in nodes {
            if node.name == "charFriend" {
                let whackSlotTapped = node.parent!.parent! as! WhackSlot
                if !whackSlotTapped.isPenguinVisible { continue }
                if whackSlotTapped.isPenguinHit { continue }
                
                whackSlotTapped.hitPenguin()
                self.gameScore -= 5
                
                self.runAction(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
            }
            else if node.name == "charEnemy" {
                let whackSlotTapped = node.parent!.parent! as! WhackSlot
                if !whackSlotTapped.isPenguinVisible { continue }
                if whackSlotTapped.isPenguinHit { continue }
                
                whackSlotTapped.penguineImageSpriteNode.xScale = 0.85
                whackSlotTapped.penguineImageSpriteNode.yScale = 0.85
                
                whackSlotTapped.hitPenguin()
                ++self.gameScore
                
                self.runAction(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    // MARK: - Custom Methods
    
    func createSlotAt(coordinate: CGPoint) {
        let whackSlot = WhackSlot()
        whackSlot.configureHoleAtPosition(coordinate)
        self.whackSlotArray.append(whackSlot)
        self.addChild(whackSlot)
    }
    
    func createPenguin() {
        self.penguinPopupTime *= 0.991
        
        ++self.numberOfGameRounds
        
        if self.numberOfGameRounds >= 30 {
            for slot in self.whackSlotArray { slot.hidePenguin() }
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            self.addChild(gameOver)
            
            return
        }
        
        self.whackSlotArray.shuffle()
        self.whackSlotArray.first?.showPenguin(hideTime: self.penguinPopupTime)
        
        if RandomInt(min: 0, max: 12) > 4 { self.whackSlotArray[1].showPenguin(hideTime: self.penguinPopupTime) }
        if RandomInt(min: 0, max: 12) > 8 { self.whackSlotArray[2].showPenguin(hideTime: self.penguinPopupTime) }
        if RandomInt(min: 0, max: 12) > 10 { self.whackSlotArray[3].showPenguin(hideTime: self.penguinPopupTime) }
        if RandomInt(min: 0, max: 12) > 11 { self.whackSlotArray[4].showPenguin(hideTime: self.penguinPopupTime) }
            
        let minPopupDelay = self.penguinPopupTime / 2.0
        let maxPopupDelay = self.penguinPopupTime * 2.0
        
        runAfterDelay(RandomDouble(minPopupDelay, max: maxPopupDelay), block: { [unowned self] in self.createPenguin() })
    }
}
