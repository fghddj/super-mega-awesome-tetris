//
//  SOblika.swift
//  Tetris
//
//  Created by Blaz on 31/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

class SOblika:Oblika {
    /*
    Orientacija 0
    
    | 0*|
    | 1 | 2 |
        | 3 |
    
    Orientacija 90
    
      * | 1 | 0 | 
    | 3 | 2 |
    
    Orientacija 180
    
    | 0*|
    | 1 | 2 |
        | 3 |
    
    Orientacija 270
    
      * | 1 | 0 |
    | 3 | 2 |
    
    * row/column indikator
    */
    override var blockRowColumnPositions: [Orientacija: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientacija.Nula:               [(0, 0), (0, 1), (1, 1), (1, 2)],
            Orientacija.Devetdeset:         [(2, 0), (1, 0), (1, 1), (0, 1)],
            Orientacija.StoOsemdeset:       [(0, 0), (0, 1), (1, 1), (1, 2)],
            Orientacija.DvestoSedemdeset:   [(2, 0), (1, 0), (1, 1), (0, 1)]
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