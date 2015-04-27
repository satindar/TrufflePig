//
//  TruffleField.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/25/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import Foundation

class Trufflefield {
    let fieldWidth: Int
    let fieldHeight: Int
    let numberOfTruffles: Int
    
    lazy var plantedField: [Int] = { return self.plantTrufflesInField() }()
    
    init(numberOfTruffles: Int, fieldWidth: Int, fieldHeight: Int) {
        self.fieldWidth = fieldWidth
        self.fieldHeight = fieldHeight
        self.numberOfTruffles = numberOfTruffles
    }
    
    func plantTrufflesInField() -> [Int] {
        var field = Array(count: fieldHeight * fieldWidth, repeatedValue: 0)
        let truffleLocations = sampleValuesLessThan(
            fieldHeight * fieldWidth,
            ofCount: numberOfTruffles
        )
        
        for location in truffleLocations {
            field[location] = -1
            let nodesTouchingTruffle = nodesSurroundingLocation(location)
            
            for node in nodesTouchingTruffle {
                if node > -1 && node < fieldHeight * fieldWidth {
                    if field[node] >= 0 {
                        field[node] = field[node] + 1
                    }
                }
            }
        }
        return field
    }
    
    func sampleValuesLessThan(maxValue: Int, ofCount count: Int) -> [Int] {
        var field = (0...maxValue).map { $0 } // TODO: use dict for performance? (faster to remove)
        var truffleIndices = [Int]()
        
        for index in (1...count) {
            let randomIndex = Int(arc4random() % UInt32(field.count - 1))
            // TODO: use arc4random_uniform to deal with modulo bias
            truffleIndices.append(field[randomIndex])
            field.removeAtIndex(randomIndex)
        }
        return truffleIndices
    }
    
    func nodesSurroundingLocation(truffleIndex: Int) -> [Int] {
        var nodes = [Int]()
        
        if (truffleIndex % fieldWidth != (fieldWidth - 1)) {
            nodes.append(truffleIndex + 1)
            nodes.append(truffleIndex + 1 - fieldWidth)
            nodes.append(truffleIndex + 1 + fieldWidth)
        }
        
        if truffleIndex % fieldWidth != 0 {
            nodes.append(truffleIndex - 1)
            nodes.append(truffleIndex - 1 - fieldWidth)
            nodes.append(truffleIndex - 1 + fieldWidth)
        }
        
        nodes.append(truffleIndex - fieldWidth)
        nodes.append(truffleIndex + fieldWidth)
        
        return nodes
    }
}

