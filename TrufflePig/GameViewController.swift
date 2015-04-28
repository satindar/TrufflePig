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
    
    lazy var trufflefieldValues = Trufflefield(
        numberOfTruffles: 20,
        fieldWidth: 10,
        fieldHeight: 10
    ).plantedField
    var trufflefield: [FieldNode] = []
    
    
    @IBAction func startGame(sender: UIButton) {
        trufflefield = trufflefieldValues.map { FieldNode(itemValue: $0) }
        addNodesToField()
    }
    
    func addNodesToField() {
        trufflefieldView.nodesAcrossWidth = 10
        trufflefieldView.nodesAcrossHeight = 10
        for fieldNode in trufflefield {
            var nodeView = FieldNodeView(
                itemInNode: fieldNode.itemValue,
                frame: trufflefieldView.nextAvailableFrame()
            )
            nodeView.backgroundColor = UIColor.lightGrayColor()
            trufflefieldView.addSubview(nodeView)
        }
    }
    
}
