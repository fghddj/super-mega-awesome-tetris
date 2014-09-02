//
//  LOblika.swift
//  Tetris
//
//  Created by Blaz on 31/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

class LOblika:Oblika {
    /*
    Orientacija 0
    
    | 0*|
    | 1 |
    | 2 | 3 |
    
    Orientacija 90
    
    | 2*| 1 | 0 |
    | 3 |
    
    Orientacija 180
    
    | 3*| 2 |
        | 1 |
        | 0 |
    
    Orientacija 270
    
          * | 3 |
    | 0 | 1 | 2 |
    */
    override var blockRowColumnPositions: [Orientacija: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientacija.Nula:               [(0, 0), (0, 1), (0, 2), (1, 2)],
            Orientacija.Devetdeset:         [(1, 1), (0, 1), (-1, 1), (-1, 2)],
            Orientacija.StoOsemdeset:       [(0, 2), (0, 1), (0, 0), (-1, 0)],
            Orientacija.DvestoSedemdeset:   [(-1, 1), (0, 1), (1, 1), (1, 0)]
            ]
    }
    
    override var bottomBlockForOrientations: [Orientacija: Array<Block>] {
        return [
            Orientacija.Nula:               [blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.Devetdeset:         [blocks[prvaOblikaIdx], blocks[drugaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.StoOsemdeset:       [blocks[prvaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.DvestoSedemdeset:   [blocks[prvaOblikaIdx], blocks[drugaOblikaIdx], blocks[tretjaOblikaIdx]],
            ]
    }   
}