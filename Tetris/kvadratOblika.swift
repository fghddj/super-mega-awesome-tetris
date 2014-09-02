//
//  kvadratOblika.swift
//  Tetris
//
//  Created by Blaz on 31/08/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

class KvadratOblika:Oblika {
    /*
        | 0*| 1 |
        | 2 | 3 |
        
        * row/column indikator
    */
    // kvadrat se ne bo obracal
    override var blockRowColumnPositions: [Orientacija: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientacija.Nula: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientacija.StoOsemdeset: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientacija.Devetdeset: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientacija.DvestoSedemdeset: [(0, 0), (1, 0), (0, 1), (1, 1)]
        ]
    }
    
    override var bottomBlockForOrientations: [Orientacija: Array<Block>] {
        return [
            Orientacija.Nula:               [blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.StoOsemdeset:       [blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.Devetdeset:         [blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]],
            Orientacija.DvestoSedemdeset:   [blocks[tretjaOblikaIdx], blocks[cetrtaOblikaIdx]]
        ]
    }
}