//
//  tOblika.swift
//  Tetris
//
//  Created by Blaz on 31/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

class tOblika:Oblika {
    /*
    Orientacija 0
    
      * | 0 |
    | 1 | 2 | 3 |
    
    Orientacija 90
    
      * | 1 |
        | 2 | 0 |
        | 3 |
    
    Orientacija 180
    
      *
    | 1 | 2 | 3 |
        | 0 |
    
    Orientacija 270
    
      * | 1 |
    | 0 | 2 |
        | 3 |
    
    * row/column indikator
    */
    override var blockRowColumnPositions: [Orientacija: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientacija.Nula:               [(1, 0), (0, 1), (1, 1), (2, 1)],
            Orientacija.Devetdeset:         [(2, 1), (1, 0), (1, 1), (1, 2)],
            Orientacija.StoOsemdeset:       [(1, 2), (0, 1), (1, 1), (2, 1)],
            Orientacija.DvestoSedemdeset:   [(0, 1), (1, 0), (1, 1), (1, 2)]
            ]
    }
    
    override var bottomBlockForOrientations: [Orientacija: Array<Block>] {
        return [
            Orientacija.Nula:               [blocks[drugaOblikaIdx], blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.Devetdeset:         [blocks[prvaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.StoOsemdeset:       [blocks[prvaOblikaIdx], blocks[drugaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.DvestoSedemdeset:   [blocks[prvaOblikaIdx], blocks[cetrtaOblikaIdx]]
        ]
    }

}