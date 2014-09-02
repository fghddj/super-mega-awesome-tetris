//
//  GameScene.swift
//  Tetris
//
//  Created by Blaz on 30/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import SpriteKit

let BlockSize:CGFloat = 20.0

let NihajDolzinaStopnjaEna = NSTimeInterval(600)

class GameScene: SKScene {

    let igraLayer = SKNode()
    let oblikaLayer = SKNode()
    let LayerPosition = CGPoint(x: 6, y: -6)
    
    var nihaj:(() -> ())?
    var nihajDolzinaMilisekunde = NihajDolzinaStopnjaEna
    var zadnjiNihaj:NSDate?
    
    var textureCache = Dictionary<String, SKTexture>()
    
    required init(coder aDecoder: (NSCoder!)) {
        fatalError("NSCoder not suppored")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0, y: 1.0)
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 1.0)
        background.anchorPoint = CGPoint(x: 0, y: 1.0)
        addChild(background)
        
        addChild(igraLayer)
        
        let igralnaMizaTexture = SKTexture(imageNamed: "gameboard")
        let gameBoard = SKSpriteNode(texture: igralnaMizaTexture, size: CGSizeMake(BlockSize * CGFloat(numColumns), BlockSize * CGFloat(numRows)))
        gameBoard.anchorPoint = CGPoint(x:0, y:1.0)
        gameBoard.position = LayerPosition
        
        oblikaLayer.position = LayerPosition
        oblikaLayer.addChild(gameBoard)
        igraLayer.addChild(oblikaLayer)
    }
       
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if zadnjiNihaj == nil {
            return
        }
        var casPretecen = zadnjiNihaj!.timeIntervalSinceNow * -1000.0
        if casPretecen > nihajDolzinaMilisekunde {
            zadnjiNihaj = NSDate.date()
            nihaj?()
        }
    }
    
    func zacniNihaj() {
        zadnjiNihaj = NSDate.date()
    }
    func stopNihaj() {
        zadnjiNihaj = nil
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        let x: CGFloat = LayerPosition.x + (CGFloat(column) * BlockSize) + (BlockSize / 2)
        let y: CGFloat = LayerPosition.y - ((CGFloat(row) * BlockSize) + (BlockSize / 2))
        return CGPointMake(x, y)
    }
    
    func dodajPreviewOblikoNaSceno(oblika:Oblika, completion: () -> ()) {
        for (idx, block) in enumerate(oblika.blocks) {
            var texture = textureCache[block.spriteIme]
            if texture == nil {
                texture = SKTexture(imageNamed: block.spriteIme)
                textureCache[block.spriteIme] = texture
            }
            
            let sprite = SKSpriteNode(texture: texture)
            
            sprite.position = pointForColumn(block.column, row: block.row - 2)
            oblikaLayer.addChild(sprite)
            block.sprite = sprite
            
            sprite.alpha = 0
            
            let moveAction = SKAction.moveTo(pointForColumn(block.column, row:block.row), duration: NSTimeInterval(0.2))
            moveAction.timingMode = .EaseOut
            let fadeInAction = SKAction.fadeAlphaTo(0.7, duration: 0.4)
            fadeInAction.timingMode = .EaseOut
            sprite.runAction(SKAction.group([moveAction, fadeInAction]))
        }	
        runAction(SKAction.waitForDuration(0.4), completion: completion)
    }
    
    func premikPreviewOblika(oblika:Oblika, completion:() -> ()) {
        for (idx, block) in enumerate(oblika.blocks) {
            let sprite = block.sprite!
            let moveTo = pointForColumn(block.column, row: block.row)
            let moveToAction:SKAction = SKAction.moveTo(moveTo, duration: 0.2)
            moveToAction.timingMode = .EaseOut
            sprite.runAction(
                SKAction.group([moveToAction, SKAction.fadeAlphaTo(1.0, duration: 0.2)]), completion:nil)
        }
        runAction(SKAction.waitForDuration(0.2), completion: completion)
    }
    
    func redrawOblika(oblika:Oblika, completion: () -> ()) {
        for (idx, block) in enumerate(oblika.blocks) {
            let sprite = block.sprite!
            let moveTo = pointForColumn(block.column, row:block.row)
            let moveToAction:SKAction = SKAction.moveTo(moveTo, duration: 0.05)
            moveToAction.timingMode = .EaseOut
            sprite.runAction(moveToAction, completion: nil)
        }
        runAction(SKAction.waitForDuration(0.05), completion: completion)
    }
}

