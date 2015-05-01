//
//  GameViewController.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/25/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, FieldNodeDelegate {
    
    @IBOutlet weak var newGameControls: UIView!
    @IBOutlet weak var totalClicks: UILabel!
    @IBOutlet weak var trufflesRemaining: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var trufflefieldView: TrufflefieldView!
    @IBOutlet weak var endGameButton: UIButton!
    
    var fieldWidth = 15
    var fieldHeight = 15
    var numberOfTruffles = 20
    var truffleMapper: Trufflemapper?
    var trufflefield: [FieldNode] = []
    var shouldUpdateField: Bool = false
    
    @IBAction func startGame(sender: UIButton) {
        newGame()
    }
    
    @IBAction func endGameButtonPressed(sender: UIButton) {
        endGame()
    }
    
    @IBAction func difficultyLevelChanged(sender: UISlider) {
        fieldWidth = Int((sender.value * 10) + 10) // set between 10 and 20
        fieldHeight = fieldWidth
        numberOfTruffles = Int((sender.value * 30) + 10)  // set between 10 and 40
    }
    
    func newGame() {
        newGameControls?.hidden = true
        endGameButton?.hidden = false
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
    
    func unearthedFieldNode(sender: FieldNodeView) {
        let index = sender.indexValue
        if trufflefield[index].isTruffle() {
            playerLosesGame()
            return
        }
        
        trufflefield[index].pigHasDugHere = true
        if let mapper = truffleMapper {
            let nodesToClear: [Int] = mapper.emptyNodesSurroundingCurrentNode(index)
            removeButtons(nodesToClear)
        }
    }
    
    func removeButtons(indexesOfButtonsToRemove: [Int]) {
        println(indexesOfButtonsToRemove)
        for nodeIndex in indexesOfButtonsToRemove {
            trufflefield[nodeIndex].pigHasDugHere = true
            let nodes = filterSubviewsForFieldNodes()
            nodes[nodeIndex].removeButtonWithAnimation()
        }
    }
    
    private func playerLosesGame() {
        // TODO: throw bacon or something and reset props
        println("you lose!")
        endGame()
    }
    
    private func endGame() {
        endGameButton.hidden = true
        newGameControls.hidden = false
        showTruffles()
        trufflefield = []
    }
    
    private func showTruffles() {
        // get indexes of truffles
        if let mapper = truffleMapper {
            let nodesToClear: [Int] = mapper.truffleLocations
            removeButtons(nodesToClear)
        }
    }
    
    override func viewWillTransitionToSize(
        size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator
        )
    {
        if trufflefield.count > 0 {
            shouldUpdateField = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        if shouldUpdateField {
            renderNodesInField()
            shouldUpdateField = false
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
