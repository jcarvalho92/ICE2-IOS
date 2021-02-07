//
//  GameScene.swift
//  ICE2-IOS
//
//  Created by Juliana de Carvalho on 2021-02-06.
//  Copyright © 2021 Juliana de Carvalho. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var sprite: SKSpriteNode?
    private var spriteSpeed: CGFloat = 5.0
    
    override func didMove(to view: SKView) {
        
        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        self.sprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100.0, height: 100.0))
        self.addChild(self.sprite!)
        reset()
  
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    func reset(){
        self.sprite?.position.y = -700
        
        //Change the colour of the SpriteNode to random colour every time it resets
        self.sprite?.color = UIColor.init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 0.5)
        
        //Change the scale of the SpriteNode to a random value every time it resets
        self.sprite?.setScale(CGFloat.random(in: 1...3))
    }
    
    func checkBounds(){
    
        // check if sprite leaves the top boundary
        if((self.sprite?.position.y)! > 700){
            reset()
        }
    }
    
    func moveSpriteEveryFrame(){
        self.sprite?.position.y += self.spriteSpeed
        
        self.sprite?.zRotation -= self.spriteSpeed * 0.02
        
        self.sprite?.zPosition = 1

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if(self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        moveSpriteEveryFrame()
        checkBounds()
      
        
        self.lastUpdateTime = currentTime
    }
}
