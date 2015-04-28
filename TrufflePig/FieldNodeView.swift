//
//  FieldNode.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/25/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import UIKit

protocol FieldNodeDelegate {
    func didClickFieldNodeWithItemValue(value: Int)
}

class FieldNodeView: UIView {
    let item: Int

    init(itemInNode: Int, frame: CGRect) {
        self.item = itemInNode
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let label = UILabel(frame: self.bounds)
        label.font = UIFont.systemFontOfSize(UIFont.systemFontSize())
        label.textAlignment = .Center
        label.text = textForItemValue()
        label.textColor = UIColor.blackColor()
        self.addSubview(label)
        
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 0.5
        
        let nodeButton = UIButton(frame: self.bounds)
        nodeButton.backgroundColor = UIColor.whiteColor()
        nodeButton.layer.borderColor = UIColor.blackColor().CGColor
        nodeButton.layer.borderWidth = 0.75
        nodeButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(nodeButton)
    }
    
    func buttonClicked(sender: UIButton) {
        sender.removeFromSuperview()
    }
    
    func textForItemValue() -> String {
        switch (item) {
        case 0:
            return ""
        case -1:
            return "*"
        default:
            return "\(item)"
        }
    }
}
