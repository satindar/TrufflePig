//
//  TrufflefieldView.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/25/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import UIKit

class TrufflefieldView: UIView {
    var nodesAcrossWidth: Int = 10
    var nodesAcrossHeight: Int = 10
    var currentNodeCoordinate: CGPoint = CGPointMake(0, 0)
    
    var dx: CGFloat {
        return self.bounds.size.width / CGFloat(nodesAcrossWidth)
    }
    
    var dy: CGFloat {
        return self.bounds.size.height / CGFloat(nodesAcrossHeight)
    }
    
    func nextAvailableFrame() -> CGRect {
        let upperLeftCoordinate = currentNodeCoordinate
        let nextFrame = CGRectMake(
            currentNodeCoordinate.x,
            currentNodeCoordinate.y,
            dx,
            dy
        )
        incrementCurrentNodeCoordinate()
        return nextFrame
    }
    
    func incrementCurrentNodeCoordinate() {
        currentNodeCoordinate.x += dx
        if currentNodeCoordinate.x >= bounds.size.width - (dx / 2) {
            currentNodeCoordinate.x = 0
            currentNodeCoordinate.y += dy
        }
    }
}
