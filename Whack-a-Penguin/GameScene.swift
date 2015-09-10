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
        
        for i in 0 ..< 5 { self.createSlotAt(CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { self.createSlotAt(CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { self.createSlotAt(CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { self.createSlotAt(CGPoint(x: 180 + (i * 170), y: 140)) }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */

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
}
