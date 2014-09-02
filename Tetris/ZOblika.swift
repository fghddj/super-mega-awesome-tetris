//
//  ZOblika.swift
//  Tetris
//
//  Created by Blaz on 31/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

class ZOblika:Oblika {
    /*
    Orientacija 0
    
      * | 0 |
    | 2 | 1 |
    | 3 |
    
    Orientacija 90
    
    | 0 | 1*|
        | 2 | 3 |
    
    Orientacija 180
    
      * | 0 |
    | 2 | 1 |
    | 3 |
    
    Orientacija 270
    
    | 0 | 1*|
        | 2 | 3 |
    
    * row/column indikator
    */
    override var blockRowColumnPositions: [Orientacija: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientacija.Nula:               [(1, 0), (1, 1), (0, 1), (0, 2)],
            Orientacija.Devetdeset:         [(-1, 0), (0, 0), (0, 1), (1, 1)],
            Orientacija.StoOsemdeset:       [(1, 0), (1, 1), (0, 1), (0, 2)],
            Orientacija.DvestoSedemdeset:   [(-1, 0), (0, 0), (0, 1), (1, 1)]
            ]
    }
    
    override var bottomBlockForOrientations: [Orientacija: Array<Block>] {
        return [
            Orientacija.Nula:               [blocks[drugaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.Devetdeset:         [blocks[prvaOblikaIdx], blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.StoOsemdeset:       [blocks[drugaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.DvestoSedemdeset:   [blocks[prvaOblikaIdx], blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]],
            ]
    }
    
}