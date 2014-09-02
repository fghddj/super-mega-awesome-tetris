//
//  GameViewController.swift
//  Tetris
//
//  Created by Blaz on 30/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController {

    var scene: GameScene!
    var gameMaster:GameMaster!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // postavi view
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        // postavi sceno
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.nihaj = didTick
        
        gameMaster = GameMaster()
        gameMaster.zacniIgro()
        
        // pokazi sceno
        skView.presentScene(scene)
        
        scene.dodajPreviewOblikoNaSceno(gameMaster.naslednjaOblika!) {
            self.gameMaster.naslednjaOblika?.premakniNa(startingColumn, row: startingRow)
            self.scene.premikPreviewOblika(self.gameMaster.naslednjaOblika!) {
                let naslednjeOblike = self.gameMaster.novaOblika()
                self.scene.zacniNihaj()
                self.scene.dodajPreviewOblikoNaSceno(naslednjeOblike.naslednjaOblika!) {}
            }
        }
    }
    
 
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        gameMaster.padajocaOblika?.padeZaEnoVrstico()
        scene.redrawOblika(gameMaster.padajocaOblika!, completion: {})
    }
}
