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
    
    lazy var trufflefield = Trufflefield(
        numberOfTruffles: 20,
        fieldWidth: 10,
        fieldHeight: 10
    ).plantedField
    
    @IBAction func startGame(sender: UIButton) {
        addNodesToField()
    }
    
    func addNodesToField() {
        trufflefieldView.nodesAcrossWidth = 10
        trufflefieldView.nodesAcrossHeight = 10
        for fieldNodeValue in trufflefield {
            let fieldNode = FieldNodeView(
                itemInNode: fieldNodeValue,
                frame: trufflefieldView.nextAvailableFrame()
            )
            fieldNode.backgroundColor = UIColor.lightGrayColor()
            trufflefieldView.addSubview(fieldNode)
        }
    }
}
