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

class GameMaster {
    var blockArray:Array2D<Block>
    var naslednjaOblika:Oblika?
    var padajocaOblika:Oblika?
    
    init() {
        padajocaOblika = nil
        naslednjaOblika = nil
        blockArray = Array2D<Block>(columns: numColumns, rows: numRows)
    }
    
    func zacniIgro() {
        if (naslednjaOblika == nil) {
            naslednjaOblika = Oblika.random(previewColumn, startingRow: previewRow)
        }
    }
    
    func novaOblika() -> (padajocaOblika:Oblika?, naslednjaOblika:Oblika?) {
        padajocaOblika = naslednjaOblika
        naslednjaOblika = Oblika.random(previewColumn, startingRow: previewRow)
        padajocaOblika?.premakniNa(startingColumn, row: startingRow)
        return (padajocaOblika, naslednjaOblika)
    }
}