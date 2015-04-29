//
//  FieldNode.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/25/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import UIKit

protocol FieldNodeDelegate: class {
    func clickedFieldNodeWithIndexValue(sender: FieldNodeView)
}

class FieldNodeView: UIView {
    let item: Int
    let indexValue: Int
    var unearthed: Bool

    init(itemInNode: Int, selected: Bool, frame: CGRect, index: Int) {
        self.item = itemInNode
        self.unearthed = selected
        self.indexValue = index
        super.init(frame: frame)
    }
    
    weak var delegate: FieldNodeDelegate?
    
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
        
        if unearthed == false {
            let nodeButton = UIButton(frame: self.bounds)
            nodeButton.backgroundColor = UIColor.whiteColor()
            nodeButton.layer.borderColor = UIColor.blackColor().CGColor
            nodeButton.layer.borderWidth = 0.75
            nodeButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(nodeButton)
        }
    }
    
    func buttonClicked(sender: UIButton) {
        delegate?.clickedFieldNodeWithIndexValue(self)
        self.unearthed = true
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
