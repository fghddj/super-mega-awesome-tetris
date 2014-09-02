//
//  ravnaOblika.swift
//  Tetris
//
//  Created by Blaz on 31/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

class ravnaOblika:Oblika {
    /*
    0 in 180
    
    | 0*|
    | 1 |
    | 2 |
    | 3 |
    
    90 in 270
    
    | 0 | 1*| 2 | 3 |
    
    * row/column indikator
    */
    
    override var blockRowColumnPositions: [Orientacija: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientacija.Nula:               [(0, 0), (0, 1), (0, 2), (0, 3)],
            Orientacija.Devetdeset:         [(-1, 0), (0, 0), (1, 0), (2, 0)],
            Orientacija.StoOsemdeset:       [(0, 0), (0, 1), (0, 2), (0, 3)],
            Orientacija.DvestoSedemdeset:   [(-1, 0), (0, 0), (1, 0), (2, 0)]
            ]
    }
    
    override var bottomBlockForOrientations: [Orientacija: Array<Block>] {
        return [
            Orientacija.Nula:               [blocks[cetrtaOblikaIdx]],
            Orientacija.Devetdeset:         blocks,
            Orientacija.StoOsemdeset:       [blocks[cetrtaOblikaIdx]],
            Orientacija.DvestoSedemdeset:   blocks
        ]
    }

    
}