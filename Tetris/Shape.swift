//
//  Shape.swift
//  Tetris
//
//  Created by Blaz on 30/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation
import SpriteKit

let steviloOrientacij: UInt32 = 4

enum Orientacija: Int, Printable {
    case Nula = 0, Devetdeset, StoOsemdeset, DvestoSedemdeset
    
    var description: String {
        switch self {
        case .Nula:
            return "0"
        case .Devetdeset:
            return "90"
        case .StoOsemdeset:
            return "180"
        case .DvestoSedemdeset:
            return "270"
        }
    }
    
    static func random() -> Orientacija {
        return Orientacija.fromRaw(Int(arc4random_uniform(steviloOrientacij)))!
    }
    
    static func rotate(orientation:Orientacija, clockwise: Bool) -> Orientacija {
        var rotiran = orientation.toRaw() + (clockwise ? 1 : -1)
        if rotiran > Orientacija.DvestoSedemdeset.toRaw() {
            rotiran = Orientacija.Nula.toRaw()
        } else if rotiran < 0 {
            rotiran = Orientacija.DvestoSedemdeset.toRaw()
        }
        return Orientacija.fromRaw(rotiran)!
        
    }
}

let steviloTipovOblik: UInt32 = 7

let prvaOblikaIdx: Int = 0
let drugaOblikaIdx: Int = 1
let tretjaOblikaIdx: Int = 2
let cetrtaOblikaIdx: Int = 3

class Oblika: Hashable, Printable {
    let barva:BlockColor
    var blocks = Array<Block>()
    var orientacija: Orientacija
    var column, row:Int
    
    // potrebni override
    // Subclasses morajo prepisati to
    var blockRowColumnPositions: [Orientacija: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    // subclasses morajo prepisati to
    var bottomBlockForOrientations: [Orientacija: Array<Block>] {
        return [:]
    }
    var bottomBlocks:Array<Block> {
        if let bottomBlocks = bottomBlockForOrientations[orientacija] {
            return bottomBlocks
            }
            return []
    }
    var hashValue:Int {
        return reduce(blocks, 0) { $0.hashValue ^ $1.hashValue }
    }
    var description:String {
        return "\(barva) block facing \(orientacija): \(blocks[prvaOblikaIdx]), \(blocks[drugaOblikaIdx]), \(blocks[tretjaOblikaIdx]), \(blocks[cetrtaOblikaIdx])"
    }
    
    init(column:Int, row:Int, color: BlockColor, orientacija:Orientacija) {
        self.barva = color
        self.column = column
        self.row = row
        self.orientacija = orientacija
        initializeBlocks()
    }
    
    convenience init(column:Int, row:Int) {
        self.init(column:column, row:row, color:BlockColor.random(), orientacija:Orientacija.random())
    }
    
    final func initializeBlocks() {
        if let blockRowColumnTranslations = blockRowColumnPositions[orientacija] {
            for i in 0..<blockRowColumnTranslations.count {
                let blockRow = row + blockRowColumnTranslations[i].rowDiff
                let blockColumn = column + blockRowColumnTranslations[i].columnDiff
                let newBlock = Block(column: blockColumn, row: blockRow, color: barva)
                blocks.append(newBlock)
            }
        }
    }
    
    final func rotirajBlocks(orientacija: Orientacija) {
        if let blockRowColumnTranslation:Array<(columnDiff: Int, rowDiff: Int)> = blockRowColumnPositions[orientacija] {
            for (idx, (columnDiff:Int, rowDiff:Int)) in enumerate(blockRowColumnTranslation) {
                blocks[idx].column = column + columnDiff
                blocks[idx].row = row + rowDiff
            }
        }
    }
    
    final func rotirajClockwise() {
        let novaOrientacija = Orientacija.rotate(orientacija, clockwise: true)
        rotirajBlocks(novaOrientacija)
        orientacija = novaOrientacija
    }
    
    final func rotirajCounterClockwise() {
        let novaOrientacija = Orientacija.rotate(orientacija, clockwise: false)
        rotirajBlocks(novaOrientacija)
        orientacija = novaOrientacija
    }
    
    final func padeZaEnoVrstico() {
        premakniZa(0, rows:1)
    }
    
    final func zvisaZaEnoVrstico() {
        premakniZa(0, rows: -1)
    }
    
    final func desnoZaEnStolpec() {
        premakniZa(1, rows: 0)
    }
    
    final func levoZaEnStolpec() {
        premakniZa(-1, rows: 0)
    }
    
    final func premakniZa(columns: Int, rows: Int) {
        self.column += columns
        self.row += rows
        for block in blocks {
            block.column += columns
            block.row += rows
        }
    }
    
    final func premakniNa(column: Int, row: Int) {
        self.column = column
        self.row = row
        rotirajBlocks(orientacija)
    }
    
    final class func random(startingColumn:Int, startingRow:Int) -> Oblika {
        switch Int(arc4random_uniform(steviloTipovOblik)) {
        case 0:
            return KvadratOblika(column:startingColumn, row:startingRow)
        case 1:
            return ravnaOblika(column:startingColumn, row:startingRow)
        case 2:
            return tOblika(column:startingColumn, row:startingRow)
        case 3:
            return LOblika(column:startingColumn, row:startingRow)
        case 4:
            return JOblika(column:startingColumn, row:startingRow)
        case 5:
            return SOblika(column:startingColumn, row:startingRow)
        default:
            return ZOblika(column:startingColumn, row:startingRow)
        }
    }
}

func ==(lhs: Oblika, rhs: Oblika) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}