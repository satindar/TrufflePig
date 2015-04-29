//
//  GameViewController.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/25/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var trufflefieldView: TrufflefieldView!
    
    var fieldWidth = 10
    var fieldHeight = 10
    let numberOfTruffles = 20
    var trufflefield: [FieldNode] = []
    
    
    @IBAction func startGame(sender: UIButton) {
        newGame()
    }
    
    func newGame() {
        let trufflefieldValues = Trufflefield(
            numberOfTruffles: numberOfTruffles,
            fieldWidth: fieldWidth,
            fieldHeight: fieldHeight
        ).plantedField
        
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
            trufflefieldView.addSubview(nodeView)
        }
    }
}
