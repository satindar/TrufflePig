//
//  Trufflemapper.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/25/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import Foundation

class Trufflemapper {
    let fieldWidth: Int
    let fieldHeight: Int
    let numberOfTruffles: Int
    var clearedNodes = [Int:Bool]()
    
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
                if field[node] >= 0 {
                    field[node] = field[node] + 1
                }
            }
        }
        return field
    }
    
    func sampleValuesLessThan(maxValue: Int, ofCount count: Int) -> [Int] {
        var field = (0...maxValue).map { $0 }
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
        
        return nodes.filter({ $0 >= 0 && $0 < (self.fieldHeight * self.fieldWidth) })
    }
    
    
    func emptyNodesSurroundingCurrentNode(nodeIndex: Int) -> [Int] {
        var nodesToClear = [Int]()
        
        if plantedField[nodeIndex] != 0 {
            clearedNodes[nodeIndex] = true
            return nodesToClear
        }
       
        for node in nodesSurroundingLocation(nodeIndex) {
            if clearedNodes[node] == nil && plantedField[node] > -1 {
                nodesToClear.append(node)
                clearedNodes[node] = true
                
                if plantedField[node] == 0 {
                    for linkedNode in emptyNodesSurroundingCurrentNode(node) {
                        nodesToClear.append(linkedNode)
                    }
                }
            }
        }
        return nodesToClear
    }
}
