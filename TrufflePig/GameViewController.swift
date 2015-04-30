//
//  GameViewController.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/25/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, FieldNodeDelegate {
    
    @IBOutlet weak var trufflefieldView: TrufflefieldView!
    
    var fieldWidth = 15
    var fieldHeight = 15
    let numberOfTruffles = 20
    var truffleMapper: Trufflemapper?
    var trufflefield: [FieldNode] = []
    
    @IBAction func startGame(sender: UIButton) {
        newGame()
    }
    
    func newGame() {
        truffleMapper = Trufflemapper(
            numberOfTruffles: numberOfTruffles,
            fieldWidth: fieldWidth,
            fieldHeight: fieldHeight
        )
        let trufflefieldValues = truffleMapper!.plantedField
        
        trufflefield = trufflefieldValues.map { FieldNode(itemValue: $0) }
        renderNodesInField()
    }
    
    func renderNodesInField() {
        trufflefieldView.nodesAcrossWidth = fieldWidth
        trufflefieldView.nodesAcrossHeight = fieldHeight
        for (index, fieldNode) in enumerate(trufflefield) {
            var nodeView = FieldNodeView(
                itemInNode: fieldNode.itemValue,
                selected: fieldNode.pigHasDugHere,
                frame: trufflefieldView.nextAvailableFrame(),
                index: index
            )
            nodeView.backgroundColor = UIColor.lightGrayColor()
            nodeView.delegate = self
            trufflefieldView.addSubview(nodeView)
        }
    }
    
    func clickedFieldNodeWithIndexValue(sender: FieldNodeView) {
        let index = sender.indexValue
        trufflefield[index].pigHasDugHere = true
        
        if let mapper = truffleMapper {
            let nodesToClear: [Int] = mapper.emptyNodesSurroundingCurrentNode(index)

            for nodeIndex in nodesToClear {
                trufflefield[nodeIndex].pigHasDugHere = true
                // TODO: the next line is very unstable. Filter using the class type and indexValue instead
                if let fieldNode = trufflefieldView.subviews[nodeIndex + 1] as? FieldNodeView {
                    fieldNode.removeButtonWithAnimation()
                }
            }
        }
    }
}
