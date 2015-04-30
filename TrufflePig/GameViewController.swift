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
        let nodes = filterSubviewsForFieldNodes()
        for node in nodes {
            node.removeFromSuperview()
        }
        println(trufflefieldView.subviews.count)
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
                let nodes = filterSubviewsForFieldNodes()
                nodes[nodeIndex].removeButtonWithAnimation()
            }
        }
    }
    
    override func viewWillTransitionToSize(
        size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator
        )
    {
        if trufflefield.count > 0 {
            renderNodesInField()
        }
    }
    
    // TODO: Use generics for this method and pass in the type to filter??
    private func filterSubviewsForFieldNodes() -> [FieldNodeView] {
        var nodes = [FieldNodeView]()
        // TODO: use filter here? or a find method if such a thing exists already?
        for subview in trufflefieldView.subviews {
            if let subviewNode = subview as? FieldNodeView {
                nodes.append(subviewNode)
            }
        }
        return nodes
    }
}
