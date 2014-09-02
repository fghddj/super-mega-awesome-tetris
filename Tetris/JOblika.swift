//
//  JOblika.swift
//  Tetris
//
//  Created by Blaz on 31/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

class JOblika:Oblika {
    /*
    Orientacija 0
    
      * | 0 |
        | 1 |
    | 3 | 2 |
    
    Orientacija 90
    
    | 3*|
    | 2 | 1 | 0 |
    
    Orientacija 180
    
    | 2*| 3 |
    | 1 |
    | 0 |
    
    Orientacija 270
    
    | 0*| 1 | 2 |
            | 3 |
    
    * row/column indikator
    */
    override var blockRowColumnPositions: [Orientacija: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientacija.Nula:               [(1, 0), (1, 1), (1, 2), (0, 2)],
            Orientacija.Devetdeset:         [(2, 1), (1, 1), (0, 1), (0, 0)],
            Orientacija.StoOsemdeset:       [(0, 2), (0, 1), (0, 0), (1, 0)],
            Orientacija.DvestoSedemdeset:   [(0, 0), (1, 0), (2, 0), (2, 1)]
            ]
    }
    
    override var bottomBlockForOrientations: [Orientacija: Array<Block>] {
        return [
            Orientacija.Nula:               [blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.Devetdeset:         [blocks[prvaOblikaIdx], blocks[drugaOblikaIdx], blocks[tretjaOblikaIdx]],
            Orientacija.StoOsemdeset:       [blocks[prvaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.DvestoSedemdeset:   [blocks[prvaOblikaIdx], blocks[drugaOblikaIdx], blocks[cetrtaOblikaIdx]],
            ]
    }

}