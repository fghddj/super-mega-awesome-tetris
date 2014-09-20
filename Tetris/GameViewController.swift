//
//  GameViewController.swift
//  Tetris
//
//  Created by Blaz on 30/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController, GameMasterDelegate, UIGestureRecognizerDelegate {

    var scene: GameScene!
    var gameMaster:GameMaster!
    
    var panPointReference:CGPoint?
    
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
        
        /*
        scene.dodajPreviewOblikoNaSceno(gameMaster.naslednjaOblika!) {
            self.gameMaster.naslednjaOblika?.premakniNa(startingColumn, row: startingRow)
            self.scene.premikPreviewOblika(self.gameMaster.naslednjaOblika!) {
                let naslednjeOblike = self.gameMaster.novaOblika()
                self.scene.zacniNihaj()
                self.scene.dodajPreviewOblikoNaSceno(naslednjeOblike.naslednjaOblika!) {}
            }
        }
        */
    }
    
 
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        gameMaster.rotirajObliko()
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        
        //2
        let trenutnaTocka = sender.translationInView(self.view)
        if let originalTocka = panPointReference {
            
            //3
            if abs(trenutnaTocka.x - originalTocka.x) > (BlockSize * 0.9) {
                
                //4
                if sender.velocityInView(self.view).x > CGFloat(0) {
                    gameMaster.premakniOblikoDesno()
                    panPointReference = trenutnaTocka
                } else {
                    gameMaster.premakniOblikoLevo()
                    panPointReference = trenutnaTocka
                }
            }
        } else if sender.state == .Began {
            panPointReference = trenutnaTocka
        }
    }
    
    
    func didTick() {
        gameMaster.pustiOblikaPada()
    }
    
    func naslednjaOblika() {
        let noveOblike = gameMaster.novaOblika()
        if let padajocaOblika = noveOblike.padajocaOblika {
            self.scene.dodajPreviewOblikoNaSceno(noveOblike.naslednjaOblika!) {}
            self.scene.premikPreviewOblika(padajocaOblika) {
                // bool da lahko prekinemo interakcijo z view med animacijami in kalkulacijami
                // da se izognemo nepredvidenim igralnim stanjem
                self.view.userInteractionEnabled = true
                self.scene.zacniNihaj()
            }
        }
    }
    
    func igraSeZacne(gameMaster: GameMaster) {
        if gameMaster.naslednjaOblika != nil && gameMaster.naslednjaOblika!.blocks[0].sprite == nil {
            scene.dodajPreviewOblikoNaSceno(gameMaster.naslednjaOblika!) {
                self.naslednjaOblika()
            }
        } else {
            naslednjaOblika()
        }
    }
    
    func igraSeKoncala(gameMaster: GameMaster) {
        view.userInteractionEnabled = false
        scene.stopNihaj()
    }
    
    func igraLevelUp(gameMaster: GameMaster) {
        
    }
    
    func igraOblikaDrop(gameMaster: GameMaster) {
        
    }
    
    func igraOblikaPristane(gameMaster: GameMaster) {
        scene.stopNihaj()
        naslednjaOblika()
    }
     // redraw sprite na novih lokacijah
    func igraOblikaPremika(gameMaster: GameMaster) {
        scene.redrawOblika(gameMaster.padajocaOblika!) {}
    }
}
