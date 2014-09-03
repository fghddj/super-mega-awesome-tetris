//
//  GameMaster.swift
//  Tetris
//
//  Created by Blaz on 31/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

let numColumns = 20
let numRows = 20

let startingColumn = 4
let startingRow = 0

let previewColumn = 12
let previewRow = 1

let TockeNaVrstico = 10
let TockeZaLevel = 1000

protocol GameMasterDelegate {
    // ko se runda konca
    func igraSeKoncala(gameMaster: GameMaster)
    
    // takoj ko se runda zacne
    func igraSeZacne(gameMaster: GameMaster)
    
    // ko padajoca oblika pade
    func igraOblikaPristane(gameMaster: GameMaster)
    
    // ko padajoca oblika spremeni lokacijo
    func igraOblikaPremika(gameMaster: GameMaster)
    
    // ko padajoca oblika spremeni lokacijo ko pade
    func igraOblikaDrop(gameMaster: GameMaster)
    
    // ko je nova stopnja
    func igraLevelUp(gameMaster: GameMaster)
}

class GameMaster {
    var blockArray:Array2D<Block>
    var naslednjaOblika:Oblika?
    var padajocaOblika:Oblika?
    var delegate:GameMasterDelegate?
    
    var score:Int
    var level:Int
    
    init() {
        score = 0
        level = 1
        padajocaOblika = nil
        naslednjaOblika = nil
        blockArray = Array2D<Block>(columns: numColumns, rows: numRows)
    }
    
    func zacniIgro() {
        if (naslednjaOblika == nil) {
            naslednjaOblika = Oblika.random(previewColumn, startingRow: previewRow)
        }
        delegate?.igraSeZacne(self)
    }
    
    func novaOblika() -> (padajocaOblika:Oblika?, naslednjaOblika:Oblika?) {
        padajocaOblika = naslednjaOblika
        naslednjaOblika = Oblika.random(previewColumn, startingRow: previewRow)
        padajocaOblika?.premakniNa(startingColumn, row: startingRow)
        
        if zaznajNeveljavnoPostavitev() {
            naslednjaOblika = padajocaOblika
            naslednjaOblika!.premakniNa(previewColumn, row: previewRow)
            koncajIgro()
            return (nil, nil)
        }
        return (padajocaOblika, naslednjaOblika)
    }
    
    func zaznajNeveljavnoPostavitev() -> Bool {
        if let oblika = padajocaOblika {
            for block in oblika.blocks {
                if block.column < 0 || block.column >= numColumns
                    || block.row < 0 || block.row >= numRows {
                        return true
                } else if blockArray[block.column, block.row] != nil {
                    return true
                }
            }
        }
        return false
    }
    
    func postaviObliko() {
        if let oblika = padajocaOblika {
            for block in oblika.blocks {
                blockArray[block.column, block.row] = block
            }
            padajocaOblika = nil
            delegate?.igraOblikaPristane(self)
        }
    }
    
    func zaznajDotik() -> Bool {
        if let oblika = padajocaOblika {
            for bottomBlock in oblika.bottomBlocks {
                if bottomBlock.row == numRows - 1 ||
                    blockArray[bottomBlock.column, bottomBlock.row + 1] != nil {
                        return true
                }
            }
        }
        return false
    }
    
    func koncajIgro() {
        score = 0
        level = 1
        delegate?.igraSeKoncala(self)
    }
    
    func dropOblika() {
        if let oblika = padajocaOblika {
            while zaznajNeveljavnoPostavitev() == false {
                oblika.padeZaEnoVrstico()
            }
            oblika.zvisaZaEnoVrstico()
            delegate?.igraOblikaDrop(self)
        }
    }
    
    func pustiOblikaPada() {
        if let oblika = padajocaOblika {
            oblika.padeZaEnoVrstico()
            if zaznajNeveljavnoPostavitev() {
                oblika.zvisaZaEnoVrstico()
                if zaznajNeveljavnoPostavitev() {
                    koncajIgro()
                } else {
                    postaviObliko()
                }
            } else {
                delegate?.igraOblikaPremika(self)
                if zaznajDotik() {
                    postaviObliko()
                }
            }
        }
    }
    
    func rotirajObliko() {
        if let oblika = padajocaOblika {
            oblika.rotirajClockwise()
            if zaznajNeveljavnoPostavitev() {
                oblika.rotirajCounterClockwise()
            } else {
                delegate?.igraOblikaPremika(self)
            }
        }
    }
    
    func premakniOblikoLevo() {
        if let oblika = padajocaOblika {
            oblika.levoZaEnStolpec()
            if zaznajNeveljavnoPostavitev() {
                oblika.desnoZaEnStolpec()
                return
            }
            delegate?.igraOblikaPremika(self)
        }
    }
    
    func premakniOblikoDesno() {
        if let oblika = padajocaOblika {
            oblika.desnoZaEnStolpec()
            if zaznajNeveljavnoPostavitev() {
                oblika.levoZaEnStolpec()
                return
            }
            delegate?.igraOblikaPremika(self)
        }
    }
}